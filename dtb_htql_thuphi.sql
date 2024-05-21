use htql_thuphi;

-- Bảng trường học
CREATE TABLE schools (
    school_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(100)
);


-- Bảng học sinh
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('male', 'female', 'other') NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    class_id INT,
    school_id INT,
    year_id INT,
    semester_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (school_id) REFERENCES schools(school_id),
    FOREIGN KEY (year_id) REFERENCES academic_years(year_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);

-- Bảng phụ huynh
CREATE TABLE parents (
    parent_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- bảng quan hệ phụ huynh và học sinh
CREATE TABLE student_parent (
    student_id INT,
    parent_id INT,
    relationship ENUM('father', 'mother', 'guardian', 'other') NOT NULL,
    PRIMARY KEY (student_id, parent_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (parent_id) REFERENCES parents(parent_id)
);

-- bảng học phí
CREATE TABLE fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    due_date DATE,
    school_id INT,
    FOREIGN KEY (school_id) REFERENCES schools(school_id)
);

-- Bảng thanh toán xử lý qua VN Pay
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    fee_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE,
    payment_method ENUM('cash', 'credit_card', 'bank_transfer', 'online', 'vnpay'),
    vnpay_transaction_id VARCHAR(100),
    vnpay_status VARCHAR(50),
    vnpay_response_code VARCHAR(10),
    semester_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (fee_id) REFERENCES fees(fee_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);

-- Bảng giáo viên
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other'),
    address VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE,
    department VARCHAR(100)
);

-- Bảng khối
CREATE TABLE grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    grade_name VARCHAR(50) NOT NULL
);

-- Bảng lớp học
CREATE TABLE classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50) NOT NULL,
    grade_id INT,
    teacher_id INT,
    school_id INT,
    year_id INT,
    semester_id INT,
    FOREIGN KEY (grade_id) REFERENCES grades(grade_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (school_id) REFERENCES schools(school_id),
    FOREIGN KEY (year_id) REFERENCES academic_years(year_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);

-- Bảng năm học
CREATE TABLE academic_years (
    year_id INT PRIMARY KEY AUTO_INCREMENT,
    start_year INT NOT NULL,
    end_year INT NOT NULL
);

-- Bảng học kì
CREATE TABLE semesters (
    semester_id INT PRIMARY KEY AUTO_INCREMENT,
    semester_name VARCHAR(50) NOT NULL,
    year_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (year_id) REFERENCES academic_years(year_id)
);

-- Bảng học phí miễn giảm
CREATE TABLE scholarships (
    scholarship_id INT PRIMARY KEY AUTO_INCREMENT,
    scholarship_name VARCHAR(100) NOT NULL,
    description TEXT,
    amount DECIMAL(10, 2) NOT NULL,
    school_id INT,
    FOREIGN KEY (school_id) REFERENCES schools(school_id)
);

-- Bảng liên kết học phí miễn giảm
CREATE TABLE student_scholarships (
    student_id INT,
    scholarship_id INT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (student_id, scholarship_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (scholarship_id) REFERENCES scholarships(scholarship_id)
);

