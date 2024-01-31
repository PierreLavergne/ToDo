package com.middleware.todo.model;

import java.util.Date;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.UuidGenerator;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotEmpty;
import lombok.AccessLevel;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "todos")
@Data
@ToString
@NoArgsConstructor
public class TodoModel {
	@Id
	@UuidGenerator
	private String id;

	@NotEmpty(message = "Name is mandatory")
	private String name;

	private String description;

	private Date deadline;

	@Enumerated(EnumType.STRING)
	private TodoPriority label;

	@Enumerated(EnumType.STRING)
	private TodoStatus status;

	@CreationTimestamp
	@Column(name = "created_at")
	private Date createdAt;

	@UpdateTimestamp
	@Column(name = "updated_at")
	private Date updatedAt;

	public TodoModel(String name, String description, Date deadline, TodoPriority label, TodoStatus status) {
		this.name = name;
		this.description = description;
		this.deadline = deadline;
		this.label = label;
		this.status = status;
	}

	public enum TodoPriority {
		Low, Medium, Important, Urgent
	}

	public enum TodoStatus {
		Active, Pending, Done
	}
}
