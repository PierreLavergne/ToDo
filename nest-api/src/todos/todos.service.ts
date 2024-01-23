import { Injectable } from '@nestjs/common';
import { Todo } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { TodoDTO } from './dto/todo.dto';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';

@Injectable()
export class TodosService {
  constructor(private readonly prisma: PrismaService) {}

  async create(todoDto: TodoDTO): Promise<Todo> {
    return this.prisma.todo
      .create({
        data: todoDto,
      })
      .then((todo: Todo) => {
        return todo;
      })
      .catch((err: PrismaClientKnownRequestError) => {
        throw err;
      });
  }

  async getAll(): Promise<Todo[]> {
    return this.prisma.todo
      .findMany()
      .then((todos: Todo[]) => {
        return todos;
      })
      .catch((err: PrismaClientKnownRequestError) => {
        throw err;
      });
  }

  async getByName(name: string): Promise<Todo> {
    return this.prisma.todo
      .findUniqueOrThrow({
        where: {
          name: name,
        },
      })
      .then((todo: Todo) => {
        return todo;
      })
      .catch((err: PrismaClientKnownRequestError) => {
        throw err;
      });
  }

  async updateById(id: string, todo: TodoDTO): Promise<Todo> {
    return this.prisma.todo
      .update({
        where: {
          id: id,
        },
        data: todo,
      })
      .then((todo: Todo) => {
        return todo;
      })
      .catch((err: PrismaClientKnownRequestError) => {
        throw err;
      });
  }

  async deleteById(id: string): Promise<Todo> {
    return this.prisma.todo
      .delete({
        where: {
          id: id,
        },
      })
      .then((todo: Todo) => {
        return todo;
      })
      .catch((err: PrismaClientKnownRequestError) => {
        throw err;
      });
  }
}
