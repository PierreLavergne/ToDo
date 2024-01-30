import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { TodosService } from './todos.service';
import { TodoDTO } from './dto/todo.dto';
import { Todo } from '@prisma/client';
import { ApiTags } from '@nestjs/swagger';
import { UpdateTodoDTO } from './dto/update-todo.dto';

@ApiTags('Todos')
@Controller('todos')
export class TodosController {
  constructor(private readonly todosService: TodosService) {}

  @Get()
  async getTodos(): Promise<Todo[]> {
    return this.todosService.getAll();
  }

  @Post()
  async createTodo(@Body() todo: TodoDTO): Promise<Todo> {
    return this.todosService.create(todo);
  }

  @Put()
  async updateTodo(@Body() todo: UpdateTodoDTO): Promise<Todo> {
    return this.todosService.update(todo);
  }

  @Get(':name')
  async getTodoByName(@Param('name') name: string): Promise<Todo> {
    return this.todosService.getByName(name);
  }

  @Delete(':name')
  async deleteTodo(@Param('name') name: string): Promise<string> {
    return this.todosService.deleteByName(name);
  }
}
