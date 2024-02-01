import { ApiProperty } from '@nestjs/swagger';
import { TodoPriority, TodoStatus } from '@prisma/client';
import {
  IsEnum,
  IsISO8601,
  IsNotEmpty,
  IsOptional,
  IsString,
} from 'class-validator';

export class TodoDTO {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty()
  @IsString()
  @IsOptional()
  description?: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsISO8601()
  deadline: Date;

  @ApiProperty()
  @IsNotEmpty()
  @IsEnum(TodoPriority)
  label: TodoPriority;

  @ApiProperty()
  @IsNotEmpty()
  @IsEnum(TodoStatus)
  status: TodoStatus;
}
