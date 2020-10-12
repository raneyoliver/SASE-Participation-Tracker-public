import * as React from 'react';
import Button from '@material-ui/core/Button';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';

interface DeleteConfirmationDialogProps {
  deleteOpen: boolean;
  handleDeleteClickClose(): void;
  handleDelete(): void;
}

const DeleteConfirmationDialog: React.FC<DeleteConfirmationDialogProps> = ({
  deleteOpen, handleDeleteClickClose, handleDelete,
}) => (
  <div>
    <Dialog
      open={deleteOpen}
      onClose={handleDeleteClickClose}
      aria-labelledby="alert-dialog-title"
      aria-describedby="alert-dialog-description"
    >
      <DialogTitle id="alert-dialog-title">Delete Event</DialogTitle>
      <DialogContent>
        <DialogContentText id="alert-dialog-description">
          Are you sure you want to delete this event?
        </DialogContentText>
      </DialogContent>
      <DialogActions>
        <Button onClick={handleDeleteClickClose} color="primary">
          No
        </Button>
        <Button onClick={handleDelete} color="primary" autoFocus>
          Yes
        </Button>
      </DialogActions>
    </Dialog>
  </div>
);

export default DeleteConfirmationDialog;
