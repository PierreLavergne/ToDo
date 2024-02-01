import React from 'react';
import '../styles/colors.css'; // Import your CSS file
import '../styles/button.css'; // Import your CSS file

interface ButtonProps {
	size?: 'customSm' | 'customMd' | 'customLg' | 'xl' | '2xl' | '3xl';
	variant?: 'primary' | 'primaryBordered' | 'secondary' | 'tertiary' | 'validate' | 'delete';
	children: React.ReactNode;
	onClick: () => void; // Ajout de la fonction onClick
}

const Button: React.FC<ButtonProps> = ({ size = 'customMd', variant = 'primary', children, onClick }) => {
	const baseStyle = {
		padding: '6px 16px',
		fontSize: '16px',
		height: 'auto',
		fontWeight: 600,
		borderRadius: '12px',
		whiteSpace: 'normal',
	};

  	const sizes = {
	customSm: {
		padding: '6px 12px',
		fontSize: '12px',
		fontWeight: 600,
		borderRadius: '8px',
	},
	customMd: {
		padding: '6px 16px',
		fontSize: '16px',
		fontFamily: 'var(--font-family)',
		fontWeight: 600,
		borderRadius: '10px',
	},
    customLg: {
		padding: '6px 16px',
		fontSize: '20px',
		fontWeight: 600,
		borderRadius: '12px',
    },
    xl: {
		padding: '8px 24px',
		fontSize: '24px',
		fontWeight: 600,
		borderRadius: '12px',
    },
    '2xl': {
		padding: '12px 24px',
		fontSize: '28px',
		fontWeight: 600,
		borderRadius: '16px',
    },
    '3xl': {
		padding: '12px 24px',
		fontSize: '32px',
		fontWeight: 600,
		borderRadius: '16px',
    },
  };

  const variants = {
    primary: {
		backgroundColor: 'var(--blue-700)',
		color: 'var(--white)',
		border: '2px solid var(--blue-700)',
	},
	primaryBordered: {
		backgroundColor: 'var(--blue-700)',
		color: 'var(--white)',
		border: '2px solid var(--blue-400)',
	},
	secondary: {
		backgroundColor: 'var(--white)',
		color: 'var(--blue-800)',
		border: '2px solid var(--blue-200)',
	},
	tertiary: {
		backgroundColor: 'var(--grey-500)',
		color: 'var(--white)',
		border: '2px solid var(--grey-500)',
	},
	validate: {
		backgroundColor: 'var(--green-500)',
		color: 'var(--white)',
		border: '2px solid var(--green-500)',
	},
	delete: {
		backgroundColor: 'var(--red-500)',
		color: 'var(--white)',
		border: '2px solid var(--red-500)',
	},
};

	return (
		<button
			style={{
			...baseStyle,
			...sizes[size],
			...variants[variant],
		}}
		onClick={onClick} // Ajout de l'événement onClick
		>
			{children}
		</button>
	);
}

export default Button;
