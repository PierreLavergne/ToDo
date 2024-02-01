import '../styles/colors.css'; // Import your CSS file
import '../styles/appbar.css'; // Import your CSS file
import Switch from './Switch';

interface AppBarProps {
  onChange: CallableFunction;
}

const AppBar: React.FC<AppBarProps> = ({onChange}) => {

  return (
    <header className="app-bar">
      <h1 style={{ color: 'var(--grey-950)', fontFamily: 'Poppins', fontSize: '16px', fontWeight: 'bold', textAlign: 'center', margin: 'auto' }}>
        My Todo List
      </h1>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '16px' }}>
        <p style={{ color: 'var(--grey-950)', fontFamily: 'Poppins', fontSize: '14px', fontWeight: 'bold', textAlign: 'center' }}>
          Nest JS
        </p>
        <label>
            <Switch onChange={() => {
              onChange();
            }} />
        </label>
        <p style={{ color: 'var(--grey-950)', fontFamily: 'Poppins', fontSize: '14px', fontWeight: 'bold', textAlign: 'center' }}>
          Java
        </p>
      </div>
    </header>
  );
};

export default AppBar;