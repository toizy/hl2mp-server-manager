unit uCommonConsts;

interface

const
	// Hints
    T_HINT_FINDCOMMAND = 'Start typing the command name here...';
    T_HINT_COMMAND_COMBOBOX = 'Here are the last executed commands';
    T_HINT_SERVER_LIST = 'Right click here manage the list' + #13#10 + 'Double click on the server to connect';
    // Warnings and questions
    T_WARNING = 'Warning!';
    T_QUESTION = 'Queston';
    T_SETTINGS_VERSION_CONFLICT = 'The file version is different (it''s %d but should be %d)';
    T_DATA_CHANGED = 'Do you want to save changes?';
    T_DELETE_FILE_QUESTION = 'Do you really want to delete this file?';
    T_DELETE_FOLDER_QUESTION = 'Do you really want to delete this folder with ALL nested files and folders?';
    T_ENTER_FILENAME = 'Enter the name of settings file:';
    // Errors
    T_ERROR = 'Error';
    T_ERROR_INVALID_FILENAME = 'The given file name is invalid. Terminating.';
    T_ERROR_PATH_EXISTS = 'A folder with this name already exists.';
    T_ERROR_FILE_EXISTS = 'A file with this name already exists.';
    T_ERROR_INCORRECT_PATH = 'Incorrect path.';
    T_ERROR_INCORRECT_FILENAME = 'The file name contains invalid chars.';

implementation

end.
