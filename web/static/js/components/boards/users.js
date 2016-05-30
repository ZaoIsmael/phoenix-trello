export default class BoardUsers extends React.Component {
  _renderUsers() {
    return this.props.users.map((user) => {
      const index = this.props.connectedUsers.findIndex((cu) => {
        return cu.id === user.id;
      });

      const classes = classnames({ connected: index != -1 });

      return (
        <li className={classes} key={user.id}>
          <ReactGravatar className="react-gravatar" email={user.email} https/>
        </li>
      );
    });
  }
}
