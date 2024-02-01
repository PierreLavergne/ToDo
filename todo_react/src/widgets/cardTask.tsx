import React, { useState } from 'react';
import '../styles/colors.css'; // Import your CSS file
import '../styles/cardTask.css';
import { Calendar , CircleFill} from 'react-bootstrap-icons';
import { putTodos } from './../services/get_todos';


export enum LabelType { LOW, MEDIUM, IMPORTANT, URGENT }

interface CardTaskProps {
  title: string;
  description: string;
  label: LabelType;
  deadline: Date;
  animate: boolean;
  status: string;
  id: string;
  isJava: boolean;
}

const CardTask: React.FC<CardTaskProps> = ({ title, description, label, deadline, animate, status, id, isJava }) => {
  const [taskStatus, setTaskStatus] = useState(status);

  const handleStatusChange = () => {
        const newStatus = taskStatus === 'Done' ? 'Pending' : 'Done';
        setTaskStatus(newStatus);

        const labelString = LabelType[label].toString();
        const labelLastPart = labelString.split('.').pop() || '';
        const capitalizedLabel = labelLastPart.charAt(0).toUpperCase() + labelLastPart.slice(1).toLowerCase();

        putTodos({
            id: id,
            name: title,
            description: description,
            label: capitalizedLabel,
            deadline: deadline.toISOString(),
            status: newStatus,
        }, isJava);
    };

  return (
    <div className="card-task" style={{ animation: animate ? 'fadeInLeft 1s' : 'none' }}>
      <div className="card-content">
        <div className="task-info">
          <h2 className={`task-title ${taskStatus === 'Done' ? 'done' : ''}`}>{title}</h2>
          <p className={`task-description ${taskStatus === 'Done' ? 'done' : ''}`}>{description || 'No description'}</p>
          <div className="task-metadata">
            <div className={`task-label ${LabelType[label].toLowerCase()}`}>
                <CircleFill size={8} style={{ marginRight: '4px' }} />
                {LabelType[label]}
                </div>
            <div className="task-deadline">
                <Calendar size={8} style={{ marginRight: '4px' }} />
              {`${deadline.getDate()}/${deadline.getMonth() + 1}/${deadline.getFullYear()}`}
            </div>
          </div>
        </div>
        <input className="checkbox" type="checkbox" checked={taskStatus === 'Done'} onChange={handleStatusChange} style={
            isJava ? { transform: 'scale(1.5)' } : {}
        }/>
      </div>
    </div>
  );
};

export default CardTask;
