import '../styles/colors.css'; // Import your CSS file
import '../styles/appbar.css'; // Import your CSS file
import Switch from './Switch';

const AppBar: React.FC = () => {

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
            <Switch />
        </label>
        <p style={{ color: 'var(--grey-950)', fontFamily: 'Poppins', fontSize: '14px', fontWeight: 'bold', textAlign: 'center' }}>
          Java
        </p>
      </div>
    </header>
  );
};

export default AppBar;