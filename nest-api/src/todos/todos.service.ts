import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { Todo } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { TodoDTO } from './dto/todo.dto';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { UpdateTodoDTO } from './dto/update-todo.dto';

@Injectable()
export class TodosService {
  constructor(private readonly prisma: PrismaService) {}

  async create(todo: TodoDTO): Promise<Todo> {
    return this.prisma.todo
      .create({
        data: todo,
      })
      .then((todo: Todo) => {
        return todo;
      })
      .catch((err: PrismaClientKnownRequestError) => {
        if (err.code === 'P2002') {
          throw new BadRequestException(`${todo.name} already exist`);
        }
        throw new InternalServerErrorException();
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
        if (err.code === 'P2025') {
          throw new BadRequestException(`${name} do not exist`);
        }
        throw new InternalServerErrorException();
      });
  }

  async update(todo: UpdateTodoDTO): Promise<Todo> {
    return this.prisma.todo
      .update({
        where: {
          id: todo.id,
        },
        data: todo,
      })
      .then((todo: Todo) => {
        return todo;
      })
      .catch((err: PrismaClientKnownRequestError) => {
        if (err.code === 'P2002') {
          throw new BadRequestException(`${todo.name} already exist`);
        } else if (err.code === 'P2023') {
          throw new BadRequestException(`Invalid ID: ${todo.id}`);
        } else if (err.code === 'P2025') {
          throw new BadRequestException(`${todo.name} do not exist`);
        }
        throw new InternalServerErrorException();
      });
  }

  async deleteByName(name: string): Promise<string> {
    return this.prisma.todo
      .delete({
        where: {
          name: name,
        },
      })
      .then(() => {
        return 'OK';
      })
      .catch((err: PrismaClientKnownRequestError) => {
        if (err.code === 'P2025') {
          throw new BadRequestException(`${name} do not exist`);
        }
        throw new InternalServerErrorException();
      });
  }
}
