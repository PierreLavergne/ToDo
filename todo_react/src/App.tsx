import { useEffect, useState } from 'react';
import Modal from 'react-modal';
import './App.css'
import Button from './widgets/Button'
import AppBar from './widgets/Appbar'
import CardTask from './widgets/cardTask'
import Input from './widgets/CustomFields';
import Select from './widgets/CustomSeletor';
import { getTodos, postTodos } from './services/get_todos'
import { LabelType } from './widgets/cardTask'

type Task = {
  title: string;
  description: string;
  label: string;
  deadline: string;
  status: string;
  id: string;
};

const customStyles = {
  content: {
    top: '50%',
    left: '50%',
    right: 'auto',
    bottom: 'auto',
    marginRight: '-50%',
    transform: 'translate(-50%, -50%)',
    innerWidth: '80%',
    border : '2px solid #000000',
    borderRadius: '10px',
    padding: '12px',
    minWidth: '40vw',
    display: 'flex',
    gap: '8px',
    flexDirection: 'column',
  } as const,
};


function App() {
  const [todos, setTodos,] = useState<Task[]>([]);
  const [isJava] = useState(false); // ou true, selon vos besoins
  const [modalIsOpen, setIsOpen] = useState(false);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [label, setLabel] = useState('');
  const [deadline, setDeadline] = useState('');
  const [status, setStatus] = useState('');

  function openModal() {
    setIsOpen(true);
  }


  function closeModal() {
    setIsOpen(false);
  }

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
            openModal();
          }
        }>New task</Button>
        <Modal
          isOpen={modalIsOpen}
          onRequestClose={closeModal}
          style={customStyles}
          contentLabel="Example Modal"
        >
            <h2>New task</h2>
            <label>
              Title:
              <Input  placeholder="title" onChange={(value) => {
                setTitle(value.target.value);
              }}/>
            </label>
            <label>
              Description:
              <Input  placeholder="description" onChange={(value) => {
                setDescription(value.target.value);
              }}/>
            </label>
            <label>
              Deadline:
            <Input placeholder="deadline" type='date' onChange={(value) => {
                setDeadline(value.target.value);
            }}/>
            </label>
            <label>
              Label:
              <Select values={['Low', 'Medium', 'Important', 'Urgent']} onChange={(value) => {
                setLabel(value.target.value);
              }} />
            </label>
            <label>
              Status:
              <Select values={['Pending', 'Done', 'Active']} onChange={(value) => {
                setStatus(value.target.value);
              }} />
            </label>
            <div className='buttonDiv'>
              <Button variant="validate" size='customSm' onClick={() => {
                if (title === '' || label === '' || deadline === '' || status === '') {
                  alert('Please fill all the fields');
                  return;
                }
                postTodos({
                  name: title,
                  description: description,
                  label: label,
                  deadline: deadline + 'T00:00:00.000Z', // attention à bien formater la date pour l'envoyer au back
                  status: status,
                }, isJava);
                closeModal();
                todos.push({
                  title: title,
                  description: description,
                  label: label,
                  deadline: deadline + 'T00:00:00.000Z', // attention à bien formater la date pour l'envoyer au back
                  status: status,
                  id: '0',
                });
              }}>Submit</Button>
              <Button variant="primary" size="customSm" onClick={ closeModal }>Cancel</Button>
            </div>

        </Modal>

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
