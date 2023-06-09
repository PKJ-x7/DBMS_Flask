from flask import Flask, render_template, request, redirect, url_for, session, make_response, flash
from flask_login import LoginManager, login_user, current_user, login_required, logout_user, UserMixin
from flask_bcrypt import Bcrypt
import mysql.connector
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = 'DBMS_$u(k$'

login_manager = LoginManager(app)
login_manager.login_view = 'login'
# bcrypt = Bcrypt(app)


# Connect to MySQL database
db = mysql.connector.connect(
  host="localhost",
  user="root",
  password="pkj#rolls#sql",
  database="phone_directory"
)


# Get a list of tables from the database
cursor = db.cursor(buffered=True)
cursor.execute("delete from locks_")
# db.commit()
cursor.execute("SHOW TABLES")
tables = cursor.fetchall()
tables = [table[0] for table in tables]


class User(UserMixin):
    def __init__(self, id, username, password, email, role):
        self.id = id
        self.username = username
        self.password = password
        self.email = email
        self.role = role

    def is_authenticated(self):
        return True

    def is_active(self):
        return True

    def is_anonymous(self):
        return False

    def get_id(self):
        return str(self.id)

    @staticmethod
    def get_by_username(username):
        query = "SELECT * FROM phone_directory_user WHERE username=%s"
        cursor.execute(query, (username,))
        result = cursor.fetchone()

        if result:
            user = User(result[0], result[1], result[2], result[3], result[4])
            return user
        else:
            return None

@login_manager.user_loader
def load_user(id):
    query = "SELECT * FROM phone_directory_user WHERE id=%s"
    cursor.execute(query, (id,))
    result = cursor.fetchone()

    if result:
        user = User(result[0], result[1], result[2], result[3], result[4])
        return user
    else:
        return None


@app.after_request
def add_no_cache_header(response):
    print("no cache called")
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    return response


@app.route('/', methods=['GET', 'POST'])
def home_red():
    session.clear()
    return redirect(url_for('login'))

@app.route('/login/', methods=['GET', 'POST'])
def login():
    # Output message if something goes wrong...
    msg = ''
    if current_user:
        if current_user.is_authenticated:
            session.clear()
            logout_user()
    # Check if "username" and "password" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        # Check if account exists using MySQL
        cursor = db.cursor()
        cursor.execute('SELECT * FROM phone_directory_user WHERE username = %s', (username,))
        # Fetch one record and return result
        account = cursor.fetchone()
        user = User.get_by_username(username)
        # If account exists in accounts table in out database
        if user:
            if check_password_hash(user.password, password):
                login_user(user, remember=False)
                return redirect(url_for('home'))
            else:
                # Account doesnt exist or username/password incorrect
                msg = 'Incorrect password!'
        else:
            msg = 'User not found'
    else:
        # If the user is already logged in, redirect to the home page
        if current_user.is_authenticated:
            return redirect(url_for('home'))
    # Show the login form with message (if any)
    return render_template('login.html', msg=msg)


@app.route('/login/logout')
@login_required
def logout():
    # Remove session data, this will log the user out
   session.clear()
   logout_user()
   # Redirect to login page
   return redirect(url_for('login'))

# http://localhost:5000/pythinlogin/register - this will be the registration page, we need to use both GET and POST requests
@app.route('/login/register', methods=['GET', 'POST'])
def register():
    # Output message if something goes wrong...
    msg = ''
    # Check if "username", "password" and "email" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form \
            and 'role' in request.form:
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        role = request.form['role']
        # Check if account exists using MySQL
        cursor = db.cursor()
        cursor.execute('SELECT * FROM phone_directory_user WHERE username = %s', (username,))
        username_ = cursor.fetchone()
        cursor.execute('SELECT * FROM phone_directory_user WHERE email = %s', (email,))
        email_ = cursor.fetchone()
        # If account exists show error and validation checks
        if username_:
            msg = 'User already exists!'
        elif email_:
            msg = 'Email ID already exists!'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address!'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Username must contain only characters and numbers!'
        elif not username or not password or not email:
            msg = 'Please fill out the form!'
        else:
            # Account doesnt exists and the form data is valid, now insert new account into accounts table
            hash_pass = generate_password_hash(password)
            cursor.execute('INSERT INTO phone_directory_user (username, password, email, role) VALUES (%s, %s, %s, %s)', (username, hash_pass, email, role,))
            db.commit()
            user_id = cursor.lastrowid
            user = User(user_id, username, password, email, role)
            # print(user)
            msg = 'You have successfully registered!'
    elif request.method == 'POST':
        # Form is empty... (no POST data)
        msg = 'Please fill out the form!'
    # Show registration form with message (if any)
    return render_template('register.html', msg=msg)


@app.route('/login/home')
@login_required
def home():
    # Check if user is loggedin
    if current_user.is_authenticated:
        # User is loggedin show them the home page
        if current_user.role == "Admin":
            return render_template('admin_home.html', username=current_user.username)
        else:
            return render_template('home.html', username=current_user.username)
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))

# http://localhost:5000/pythinlogin/profile - this will be the profile page, only accessible for loggedin users
@app.route('/login/profile')
@login_required
def profile():
    # Check if user is loggedin
    if current_user.is_authenticated:
        # We need all the account info for the user so we can display it on the profile page
        cursor = db.cursor()
        cursor.execute('SELECT * FROM phone_directory_user WHERE id = %s', (current_user.id,))
        account = cursor.fetchone()
        # Show the profile page with account info
        return render_template('profile.html', account=account)
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))

@app.route('/admin_view')
@login_required
def admin_view():
    return render_template('admin_view.html', tables=tables)


@app.route('/table', methods=['GET', 'POST'])
@login_required
def table():
    if request.method == 'POST':
        # Get the selected table from the form
        selected_table = request.form['table']

        # Get the columns from the selected table
        # cursor.execute(f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='{selected_table}' order by ORDINAL_POSITION")
        # columns = cursor.fetchall()
        # columns = [column[0] for column in columns]
        # Get the data from the selected table

        cursor.execute(f"SELECT * FROM {selected_table}")
        columns = [desc[0] for desc in cursor.description]
        data = cursor.fetchall()

        # print(columns)
        # print(selected_table)
        # print(data)

        # Get the primary key column for the specified table from the database
        cursor.execute(
            f"SELECT column_name FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_NAME = '{selected_table}' AND CONSTRAINT_NAME = 'PRIMARY'")
        primary_key = cursor.fetchone()[0]

        return render_template('table.html', table=selected_table, columns=columns, data=data, primary_key=primary_key)

    return render_template('select_table.html', tables=tables)

@app.route('/rename_table/<table>', methods=['GET', 'POST'])
@login_required
def rename_table(table):
    # conn = mysql.connect()
    cursor = db.cursor()

    if request.method == 'POST':
        new_table_name = request.form['new_table_name']

        # Rename the table
        cursor.execute(f"ALTER TABLE {table} RENAME TO {new_table_name}")
        db.commit()


        # Retrieve updated table list
        cursor = db.cursor()
        cursor.execute("SHOW TABLES")
        tables = [table[0] for table in cursor.fetchall()]

        return render_template('admin_view.html', tables=tables)

    db.close()

    return render_template('rename_table.html', table=table)

@app.route('/add_entry', methods=['POST'])
@login_required
def add_entry():
    # Get the form data from the request
    table = request.form['table']
    values = []

    # Get the values for each column from the form
    for column in request.form:
        if column != 'table':
            values.append(request.form[column])

    # Construct the SQL query
    columns = ', '.join(request.form.keys())
    columns = columns[7:]
    placeholders = ', '.join(['%s'] * (len(request.form) - 1))
    query = f"INSERT INTO {table} ({columns}) VALUES ({placeholders})"
    # print(columns)
    # Execute the query
    cursor = db.cursor()
    cursor.execute(query, tuple(values))
    db.commit()

    return redirect(url_for('table', table=table), code=307)

@app.route('/delete_entry', methods=['POST'])
@login_required
def delete_entry():
    # Get the form data from the request
    table = request.form['table']
    primary_key = request.form['primary_key']
    value = request.form['value']
    # print(table, primary_key, type(value))
    # Construct the SQL query
    query = f"DELETE FROM {table} WHERE {primary_key} = '{value}'"
    # print(query)
    # Execute the query
    cursor = db.cursor()
    cursor.execute(query)
    db.commit()

    return redirect(url_for('table', table=table), code=307)


# function to lock a row for editing
def lock_row(table, row_id):
    # get the user ID from the session
    user_id = current_user.email

    # insert a new row into the lock table
    cursor = db.cursor()
    insert_query = "INSERT INTO locks_ (table_names, row_id, user_id) VALUES (%s, %s, %s)"
    cursor.execute(insert_query, (table, row_id, user_id))
    db.commit()


# function to release a lock on a row
def release_lock(table, row_id):
    # delete the row from the lock table
    cursor = db.cursor()
    delete_query = "DELETE FROM locks_ WHERE table_names = %s AND row_id = %s"
    cursor.execute(delete_query, (table, row_id,))
    db.commit()


# function to check if a row is locked
def is_locked(table, row_id):
    cursor = db.cursor()
    select_query = "SELECT user_id FROM locks_ WHERE table_names = %s AND row_id = %s"
    cursor.execute(select_query, (table, row_id,))
    result = cursor.fetchone()
    if result:
        return True
    else:
        return False


@app.route('/edit_entry', methods=['POST'])
@login_required
def edit_entry():
    table = request.form['table']
    primary_key = request.form['primary_key']
    value = request.form['value']

    # check if the row is already locked
    if is_locked(table, value):
        flash("This row is being edited by another user. Please try again later.")
        cursor = db.cursor()
        cursor.execute(f"SELECT * FROM {table}")
        columns = [desc[0] for desc in cursor.description]
        data = cursor.fetchall()
        cursor.execute(
            f"SELECT column_name FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_NAME = '{table}' AND CONSTRAINT_NAME = 'PRIMARY'")
        primary_key = cursor.fetchone()[0]
        return render_template('table.html' ,table=table, columns=columns, data=data, primary_key=primary_key)

    # lock the row for editing
    lock_row(table, value)
    # Get the column names for the specified table

    cursor = db.cursor(buffered=True)
    cursor.execute(f"SELECT * FROM {table}")
    columns = [desc[0] for desc in cursor.description]
    # cursor.execute(f"SELECT * FROM {table} WHERE {primary_key} = '{value}' FOR UPDATE")

    # Get the data for the row being edited
    cursor.execute(f"SELECT * FROM {table} WHERE {primary_key} = '{value}'")
    row = cursor.fetchone()
    # print(columns, row)
    # Render the edit entry template with the column names and row data
    return render_template('edit_entry.html', table=table, primary_key=primary_key, value=value, columns=columns, row=row)

@app.route('/update_entry', methods=['POST'])
@login_required
def update_entry():
    table = request.form['table']
    primary_key = request.form['primary_key']
    value = request.form['value']
    updates = {}

    # Parse the updates from the form data
    for key in request.form:
        if key != 'table' and key != 'primary_key' and key != 'value':
            updates[key] = request.form[key]

    # Generate the update query string
    update_string = ', '.join([f"{key} = '{updates[key]}'" for key in updates])

    # Execute the update query
    cursor = db.cursor()
    cursor.execute(f"UPDATE {table} SET {update_string} WHERE {primary_key} = '{value}'")
    db.commit()
    release_lock(table, value)

    # Redirect back to the table view for the updated table
    return redirect(url_for('table', table=table), code=307)

@app.route('/user_views')
@login_required
def user_views():
    return render_template('tri_options.html')

#add next links for tables
@app.route('/student_tables')
@login_required
def student_table_links():
    return render_template('student_table_links.html')

@app.route('/facilities_tables')
@login_required
def facilities_table_links():
    return render_template('facilities_table_links.html')

@app.route('/people_tables')
@login_required
def people_table_links():
    return render_template('people_table_links.html')

# Route for displaying the table for Administration option
@app.route('/faculty')
@login_required
def faculty():
    table_name = "Faculty"
    query = "SELECT faculty.faculty_id as ID, CONCAT_WS(' ',faculty.first_name,faculty.last_name) as Name, faculty_dept.dept_name as Department, faculty_dept.designation as Designation, CONCAT_WS('/',faculty_office.block_no, faculty_office.room_no) as Office, office.office_phone_number as 'Office Number'  " \
            "FROM faculty join faculty_dept on faculty.faculty_id = faculty_dept.faculty_id " \
            "join faculty_office on faculty.faculty_id = faculty_office.faculty_id " \
            "join office on faculty_office.block_no = office.block_no and faculty_office.room_no = office.room_no"
    return execute_query(query, table_name)

# can edit this func to use diff queries for diff tables similar to "members" func below
@app.route('/search', methods=['POST'])
@login_required
def search():
    table_name = request.form['table'].lower()
    # print(table_name)
    if not re.match(r'^[a-zA-Z]',request.form['search_input']):
        error = 'Do not try that again!!'
        flash(error)
        return render_template('login.html', error=error)
    name = request.form['search_input'].split()[0].capitalize()
    # print(name)
    query1 = f"SELECT faculty.faculty_id as ID, CONCAT_WS(' ',faculty.first_name,faculty.last_name) as Name, faculty_dept.dept_name as Department, faculty_dept.designation as Designation, CONCAT_WS('/',faculty_office.block_no, faculty_office.room_no) as Office, office.office_phone_number as 'Office Number'  " \
            f"FROM faculty join faculty_dept on faculty.faculty_id = faculty_dept.faculty_id " \
            f"join faculty_office on faculty.faculty_id = faculty_office.faculty_id " \
            f"join office on faculty_office.block_no = office.block_no and faculty_office.room_no = office.room_no " \
            f"where {table_name}.first_name = '{name}'"

    query2 = f"select alumni.alumni_id as ID, concat_ws(' ', alumni.first_name, alumni.last_name) as Name, " \
             f"alumni_enrolled.program_name as Program, alumni_enrolled.dept_name as Department, alumni_enrolled.end_year as 'Graduation Year' " \
             f"FROM alumni join alumni_enrolled on alumni.alumni_id = alumni_enrolled.alumni_id " \
             f"where {table_name}.first_name = '{name}'"

    query3 = f"select student.student_id as ID, concat_ws(' ', student.first_name, student.last_name) as Name, " \
             f"student_enrolled.program_name as Program, student_enrolled.dept_name as Department, student_enrolled.start_year as 'Enrolment Year' " \
             f"FROM student join student_enrolled on student.student_id = student_enrolled.student_id " \
             f"where {table_name}.first_name = '{name}'"

    query4 = f"select staff.staff_id as ID, concat_ws(' ', staff.first_name, staff.last_name) as Name FROM staff " \
             f"where {table_name}.first_name = '{name}'"

    queries = {
        'Staff': query4,
        'Student': query3,
        'Alumni': query2,
        'Faculty': query1
    }
    # cursor.execute(queries[table])
    # rows = cursor.fetchall()

    # print(query)
    table_name = table_name.capitalize()
    return execute_query(queries[table_name], table_name)

# Route for displaying the table for Establishment option
@app.route('/student')
@login_required
def student():
    table_name = "Student"
    query = "select student.student_id as ID, concat_ws(' ', student.first_name, student.last_name) as Name, student_enrolled.program_name as Program, student_enrolled.dept_name as Department, student_enrolled.start_year as 'Enrolment Year' FROM student join student_enrolled on student.student_id = student_enrolled.student_id"
    return execute_query(query, table_name)

@app.route('/staff')
@login_required
def staff():
    table_name = "Staff"
    query = "select staff.staff_id as ID, concat_ws(' ', staff.first_name, staff.last_name) as Name FROM staff "
    return execute_query(query, table_name)

# Route for displaying the table for Finance option
@app.route('/alumni')
@login_required
def alumni():
    table_name = "Alumni"
    query = "select alumni.alumni_id as ID, concat_ws(' ', alumni.first_name, alumni.last_name) as Name, alumni_enrolled.program_name as Program, alumni_enrolled.dept_name as Department, alumni_enrolled.end_year as 'Graduation Year' FROM alumni join alumni_enrolled on alumni.alumni_id = alumni_enrolled.alumni_id"
    return execute_query(query, table_name)

# Route for displaying the table for Administrative Branches option
@app.route('/student_council')
@login_required
def student_council():
    table_name = "Student Council"
    query = "select council_advisor.council_name as 'Council Name', student_council.email_id as Email, concat_ws(' ',faculty.first_name, faculty.last_name) as 'Faculty Advisor' from council_advisor join faculty on faculty.faculty_id = council_advisor.faculty_id " \
            "join student_council on student_council.council_name = council_advisor.council_name"
    return execute_query(query, table_name)

# Route for displaying the table for Admission option
@app.route('/student_group')
@login_required
def student_group():
    table_name = "Student Group"
    query = "select group_part_of.group_name as 'Group Name', student_group.email_id as Email, group_part_of.council_name as 'Part Of' from group_part_of " \
            "join student_group on student_group.group_name = group_part_of.group_name"
    return execute_query(query, table_name)

# Route for displaying the table for Examination option
@app.route('/services')
@login_required
def services():
    table_name = "Services"
    query = "select service.service_name as Service, service.email_id as Email, concat_ws('/',service_office.block_no, service_office.room_no) as Office, office.office_phone_number as 'Phone Number', concat_ws(' ',faculty.first_name, faculty.last_name) as 'Faculty Coordinator', faculty_head_service.designation as Designation " \
            "from faculty_head_service join service on service.service_name = faculty_head_service.service_name join faculty " \
            "on faculty_head_service.faculty_id = faculty.faculty_id join service_office " \
            "on service_office.service_name = service.service_name join office " \
            "on service_office.block_no = office.block_no and service_office.room_no = office.room_no"
    return execute_query(query, table_name)

# Route for displaying the table for Departments option
@app.route('/centres')
@login_required
def centre():
    table_name = "Centres"
    query = "select centre.centre_name as Centre, centre.email_id as Email, concat_ws('/', centre_office.block_no, centre_office.room_no) as Office, office.office_phone_number as 'Phone Number', concat_ws(' ', faculty.first_name, faculty.last_name) as 'Faculty Coordinator', faculty_head_centre.designation as Designation " \
            "from faculty_head_centre join centre " \
            "on centre.centre_name = faculty_head_centre.centre_name join faculty " \
            "on faculty_head_centre.faculty_id = faculty.faculty_id " \
            "join centre_office " \
            "on centre_office.centre_name = centre.centre_name " \
            "join office on centre_office.block_no = office.block_no and centre_office.room_no = office.room_no"
    return execute_query(query, table_name)

# Route for displaying the table for Hostels option
@app.route('/labs')
@login_required
def labs():
    table_name = "Labs"
    query = "select lab.lab_name as Lab, lab.email_id as Email, lab_dept.dept_name as Department, concat_ws('/',lab_office.block_no, lab_office.room_no) as Office, office.office_phone_number as 'Phone Number' from lab_dept " \
            "join lab on lab.lab_name = lab_dept.lab_name join lab_office on lab_office.lab_name = lab.lab_name " \
            "join office on lab_office.block_no = office.block_no and lab_office.room_no = office.room_no"
    return execute_query(query, table_name)


# Function to execute SQL query and render the table template
def execute_query(query, table_name="Placeholder"):
    try:
        # MySQL database connection
        cursor = db.cursor()

        # Execute the SQL query
        cursor.execute(query)

        # Fetch all rows
        rows = cursor.fetchall()
        # print(rows)
        if rows == []:
            flash('NO DATA TO SHOW')
            return redirect(url_for('faculty'))
        # Get column names
        col_names = [desc[0] for desc in cursor.description]

        # Render the table template with query results
        if table_name not in ['Student', 'Faculty', 'Alumni', 'Staff']:
            return render_template('view_members.html', table=table_name, data=rows, columns=col_names)
        else:
            return render_template('view_contacts.html', table=table_name, data=rows, columns=col_names, user_role=current_user.role)

    except mysql.connector.Error as err:
        print(err)

    # finally:
    #     # Close database connection
    #     # cursor.close()
    #     db.close()

@app.route('/members', methods=['POST'])
@login_required
def members():
    table = request.form['table']
    primary_key = request.form['primary_key']
    value = request.form['value']

    # print("MEMEBERS:", table, primary_key, value)
    cursor = db.cursor()

    query1 = f"select student.student_id as ID, concat_ws(' ',student.first_name, student.last_name) as Members, student_council_member.position as Position, student_enrolled.program_name as Program, student_enrolled.dept_name as Department,student.email_id as Email " \
             f"from student join student_council_member on student.student_id = student_council_member.student_id " \
             f"join student_enrolled " \
             f"on student.student_id = student_enrolled.student_id " \
             f"where student_council_member.council_name = '{value}'"

    query2 = f"select student.student_id as ID, concat_ws(' ',student.first_name, student.last_name) as Members, student_group_member.position as Position, student_enrolled.program_name as Program, student_enrolled.dept_name as Department,student.email_id as Email " \
             f"from student " \
             f"join student_group_member " \
             f"on student.student_id = student_group_member.student_id " \
             f"join student_enrolled " \
             f"on student.student_id = student_enrolled.student_id " \
             f"where student_group_member.group_name = '{value}'"

    query3 = f"select staff.staff_id as ID, concat_ws(' ',staff.first_name, staff.last_name) as Staff, service_staff.roles as 'Role', staff.email_id as Email from staff " \
             f"join service_staff " \
             f"on staff.staff_id = service_staff.staff_id " \
             f"where service_staff.service_name = '{value}'"

    query4 = f"select staff.staff_id as ID,concat_ws(' ',staff.first_name, staff.last_name) as Staff, centre_staff.roles as 'Role', staff.email_id as Email " \
             f"from staff " \
             f"join centre_staff " \
             f"on staff.staff_id = centre_staff.staff_id " \
             f"where centre_staff.centre_name = '{value}'"

    query5 = f"select staff.staff_id as ID,concat_ws(' ',staff.first_name, staff.last_name) as Staff, lab_staff.roles as 'Role', staff.email_id as Email " \
             f"from staff " \
             f"join lab_staff " \
             f"on staff.staff_id = lab_staff.staff_id " \
             f"where lab_staff.lab_name = '{value}'"

    queries = {
        'Student Council' : query1,
        'Student Group' : query2,
        'Services' : query3,
        'Centres' : query4,
        'Labs' : query5
    }
    cursor.execute(queries[table])
    rows = cursor.fetchall()

    # Get column names
    col_names = [desc[0] for desc in cursor.description]

    # Render the table template with query results
    return render_template('members.html', table=value, data=rows, columns=col_names)

@app.route('/contact', methods=['POST'])
@login_required
def contact():
    table = request.form['table']
    primary_key = request.form['primary_key']
    value = request.form['value']

    # print("CONTACTS:", "1", table, "2", primary_key, "3", value)
    cursor = db.cursor()

    query1 = f"select student.first_name, student.last_name, student.email_id, group_concat(student_phone_number.phone_number separator ', ') as phone_numbers " \
             f"from student " \
             f"join student_phone_number " \
             f"on student.student_id = student_phone_number.student_id " \
             f"where student.student_id = '{value}'"

    query2 = f"select alumni.first_name, alumni.last_name, alumni.email_id, group_concat(alumni_phone_number.phone_number separator ', ') as phone_numbers " \
             f"from alumni " \
             f"join alumni_phone_number " \
             f"on alumni.alumni_id = alumni_phone_number.alumni_id " \
             f"where alumni.alumni_id = '{value}'"

    query3 = f"select faculty.first_name, faculty.last_name, faculty.email_id, group_concat(faculty_phone_number.phone_number separator ', ') as phone_numbers " \
             f"from faculty " \
             f"join faculty_phone_number " \
             f"on faculty.faculty_id = faculty_phone_number.faculty_id " \
             f"where faculty.faculty_id = '{value}'"

    query4 = f"select staff.first_name, staff.last_name, staff.email_id, group_concat(staff_phone_number.phone_number separator ',') as phone_numbers " \
             f"from staff " \
             f"join staff_phone_number " \
             f"on staff.staff_id = staff_phone_number.staff_id " \
             f"where staff.staff_id = '{value}'"

    queries = {
        'Student': query1,
        'Alumni': query2,
        'Faculty': query3,
        'Staff' : query4
    }

    cursor.execute(queries[table])
    rows = cursor.fetchall()

    # Get column names
    col_names = [desc[0] for desc in cursor.description]
    # print(rows, col_names)
    return render_template('contact.html', name=rows[0][0]+" "+rows[0][1], email=rows[0][2], phone=rows[0][3])


if __name__ == '__main__':
    app.run(debug=True)

# ADD LOGIN MANAGER