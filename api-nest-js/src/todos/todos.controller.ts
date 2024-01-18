import {
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

@ApiTags('Todos')
@Controller('todos')
export class TodosController {
  constructor(private readonly todosService: TodosService) {}

  @Get()
  async getTodos(): Promise<Todo[]> {
    return this.todosService.getAll();
  }

  @Get(':name')
  async getTodoByName(@Param('name') name: string): Promise<Todo> {
    return this.todosService.getByName(name);
  }

  @Post()
  async createTodo(@Body() todo: TodoDTO): Promise<Todo> {
    return this.todosService.create(todo);
  }

  @Delete(':id')
  async deleteTodo(@Param('id') id: string): Promise<Todo> {
    return this.todosService.deleteById(id);
  }

  @Put(':id')
  async updateTodo(
    @Param('id') id: string,
    @Body() todo: TodoDTO,
  ): Promise<Todo> {
    return this.todosService.updateById(id, todo);
  }
}
