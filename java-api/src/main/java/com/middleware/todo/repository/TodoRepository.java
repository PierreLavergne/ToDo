package com.middleware.todo.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.middleware.todo.model.TodoModel;

@Repository
public interface TodoRepository extends CrudRepository<TodoModel, String> {
	public TodoModel findByName(String name);

	public Integer deleteByName(String name);
}
