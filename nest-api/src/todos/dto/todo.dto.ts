import { ApiProperty } from '@nestjs/swagger';
import { TodoPriority, TodoStatus } from '@prisma/client';
import { Transform } from 'class-transformer';
import {
  IsDate,
  IsDateString,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsString,
  MinDate,
} from 'class-validator';

export class TodoDTO {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty()
  @IsString({})
  @IsOptional()
  description?: string;

  @ApiProperty()
  @IsNotEmpty()
  @Transform( ({ value }) => new Date(value))
  @IsDate()
  @MinDate(new Date())
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
