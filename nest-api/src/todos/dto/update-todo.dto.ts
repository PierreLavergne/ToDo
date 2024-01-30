import { ApiProperty } from '@nestjs/swagger';
import { TodoDTO } from './todo.dto';
import { IsNotEmpty, IsString, IsUUID } from 'class-validator';

export class UpdateTodoDTO extends TodoDTO {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  @IsUUID()
  id: string;
}
