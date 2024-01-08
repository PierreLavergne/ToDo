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
      .then((todos: Todo) => {
        return todos;
      })
      .catch((err: PrismaClientKnownRequestError) => {
        throw err;
      });
  }
}
