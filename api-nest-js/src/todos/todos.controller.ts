import { Body, Controller, Delete, Get, Post, Put } from '@nestjs/common';
import { TodosService } from './todos.service';
import { TodoDTO } from './dto/todo.dto';
import { Todo } from '@prisma/client';

@Controller('todos')
export class TodosController {
  constructor(private readonly todosService: TodosService) {}

  @Get()
  async getTodos(): Promise<Todo[]> {
    return this.todosService.getAll();
  }

  @Get(':name')
  async getTodoByName(): Promise<any> {}

  @Post()
  async createTodo(@Body() todo: TodoDTO): Promise<Todo> {
    return this.todosService.create(todo);
  }

  @Delete(':name')
  async deleteTodo(): Promise<any> {}

  @Put()
  async updateTodo(): Promise<any> {}
}
