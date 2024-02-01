import { useEffect, useState } from 'react';
import './App.css'
import Button from './widgets/Button'
import AppBar from './widgets/Appbar'
import CardTask from './widgets/cardTask'
import { getTodos } from './services/get_todos'
import { LabelType } from './widgets/cardTask'

type Task = {
  title: string;
  description: string;
  label: string;
  deadline: string;
  status: string;
  id: string;
};


function App() {
  const [todos, setTodos] = useState<Task[]>([]);
  const [isJava] = useState(false); // ou true, selon vos besoins

  useEffect(() => {
    const fetchTodos = async () => {
      const todos = await getTodos(isJava);
      console.log(todos);
      setTodos(todos);
    }

    fetchTodos();
  }, [isJava]);

  return (
    <div className="App">
      <AppBar />
      <header className="App-header">
        <Button variant="primary" size="customSm" onClick={
          () => {
            console.log('click')
          }
        }>New task</Button>
        {todos.map((todo, index) => {
          let label: LabelType;
          switch (todo.label) {
            case "Low":
              label = LabelType.LOW;
              break;
            case "Medium":
              label = LabelType.MEDIUM;
              break;
            case "Important":
              label = LabelType.IMPORTANT;
              break;
            case "Urgent":
              label = LabelType.URGENT;
              break;
            default:
              label = LabelType.LOW; // valeur par défaut si todo.label ne correspond à aucun des cas
          }
  
          return (
            <CardTask
              key={index}
              title={todo.title as string}
              description={todo.description as string}
              label={label}
              deadline={new Date(todo.deadline)}
              animate={true}
              status={todo.status}
              id={todo.id}
              isJava={isJava}
            />
          );
        })}
      </header>
    </div>
  );
}

export default App;
