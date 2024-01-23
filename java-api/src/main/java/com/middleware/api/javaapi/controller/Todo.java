package com.middleware.api.javaapi.controller;

import javax.persistence.Entity;
import javax.persistence.Id;

import org.hibernate.annotations.UuidGenerator;

import java.util.Date;

@Entity
public class Todo {
    @Id
    @UuidGenerator
    private String uuid;

    private String name;
    private String description;
    private Date deadline;
    private TodoPriority label;

    public Todo(String name, String description, Date deadline, TodoPriority label) {
        this.name = name;
        this.description = description;
        this.deadline = deadline;
        this.label = label;
    }

    public String getUuid() {
        return uuid;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public Date getDeadline() {
        return deadline;
    }

    public TodoPriority getLabel() {
        return label;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public void setLabel(TodoPriority label) {
        this.label = label;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public enum TodoPriority {
        LOW,
        MEDIUM,
        HIGH
    }

    @Override
    public String toString() {
        return "Todo{" +
                "id=" + uuid +
                ", name='" + name +
                ", description='" + description +
                ", deadline='" + deadline +
                ", label='" + label +
                '}';
    }
}
