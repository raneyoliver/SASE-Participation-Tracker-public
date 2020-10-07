import * as React from 'react';
import Button from '@material-ui/core/Button';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';

interface UserAlreadyExistsDialogProps {
    open: boolean;
    handleClose(): void;
}

const UserAlreadyExistsDialog: React.FC<UserAlreadyExistsDialogProps> = ({ open, handleClose }) => (
  <div>
    <Dialog
      open={open}
      onClose={handleClose}
    >
      <DialogTitle id="user-already-exists-title">User Creation Error</DialogTitle>
      <DialogContent>
        <DialogContentText id="alert-dialog-description">
          The user you tried to create already exists within the system.
        </DialogContentText>
      </DialogContent>
      <DialogActions>
        <Button id="ok" onClick={handleClose} color="primary">
          Ok
        </Button>
      </DialogActions>
    </Dialog>
  </div>
);

export default UserAlreadyExistsDialog;
