package com.models;

import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;



@Entity
@Table(name = "students")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class,
property = "id")
public class Student {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@NotBlank(message = "Vui lòng nhập mã sinh viên")
	@Length(max = 6, message = "Mã sinh viên gồm 6 ký tự")
	@Length(min = 6, message = "Mã sinh viên gồm 6 ký tự")
	@Column(name = "student_code")
	private String studentCode;
	
	@NotBlank(message = "Vui lòng nhập tên sinh viên")
	@Column(name = "name")
	private String name;
	
	@NotBlank(message = "Vui lòng nhập số điện thoại")
	@Column(name = "phone")
	private String phone;
	
	
	@Column(name = "address")
	private String address;
	
	@NotBlank(message = "Vui lòng nhập địa chỉ email")
	@Column(name = "email")
	@Email(message = "Địa chỉ email không đúng")
	private String email;
	
	@NotNull(message = "Nhập ngày sinh")
	@Column(name = "birthday")
	private Date birthday;
	
	@Column(name = "gender")
	private boolean gender;
	
	@ManyToOne
	@JoinColumn(name = "class_id",referencedColumnName = "id")
	private Classroom classroom;
	
	@OneToMany(mappedBy = "student")
	private List<Score> scores;

	public Student() {
	}

	public Student(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStudentCode() {
		return studentCode;
	}

	public void setStudentCode(String studentCode) {
		this.studentCode = studentCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public boolean isGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}

	public Classroom getClassroom() {
		return classroom;
	}

	public void setClassroom(Classroom classroom) {
		this.classroom = classroom;
	}

	public List<Score> getScores() {
		return scores;
	}

	public void setScores(List<Score> scores) {
		this.scores = scores;
	}
}
