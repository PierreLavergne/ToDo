package com.middleware.todo.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.middleware.todo.model.TodoModel;
import com.middleware.todo.repository.TodoRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class TodoService {
	private final TodoRepository todoRepository;

	@Autowired
	public TodoService(TodoRepository todoRepository) {
		this.todoRepository = todoRepository;
	}

	public TodoModel create(TodoModel newTodo) {
		return todoRepository.save(newTodo);
	}

	public Iterable<TodoModel> getAll() {
		return todoRepository.findAll();
	}

	public TodoModel getByName(String name) {
		return todoRepository.findByName(name);
	}

	public Integer deleteByName(String name) {
		return todoRepository.deleteByName(name);
	}

	public TodoModel update(TodoModel newTodo) {
		if (newTodo.getId() == null) {
			return null;
		}
		try {
			final Optional<TodoModel> todo = todoRepository.findById(newTodo.getId());

			if (todo.isPresent()) {
				newTodo.setId(todo.get().getId());
				newTodo.setCreatedAt(todo.get().getCreatedAt());
				newTodo.setUpdatedAt(todo.get().getUpdatedAt());
				return todoRepository.save(newTodo);
			}
			return null;
		} catch (Exception e) {
			throw e;
		}
	}
}
