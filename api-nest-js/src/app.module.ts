import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TodosController } from './rest/todos/todos.controller';
import { TodosService } from './rest/todos/todos.service';
import { PrismaService } from './prisma/prisma.service';
import { PrismaModule } from './prisma/prisma.module';
import { TodosModule } from './rest/todos/todos.module';

@Module({
  imports: [PrismaModule, TodosModule],
  controllers: [AppController, TodosController],
  providers: [AppService, TodosService, PrismaService],
})
export class AppModule {}
