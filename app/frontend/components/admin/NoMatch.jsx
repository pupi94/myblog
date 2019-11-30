import React from 'react'
import {Result, Button} from 'antd';
import {Link} from "react-router-dom";

class NoMatch extends React.Component {
    render() {
        return (
          <Result status="404" title="404" subTitle="Sorry, the page you visited does not exist."
                  extra={<Link to='/admin'><Button type="primary">Back Home</Button></Link> }
          />
        );
    }
}
export default NoMatch;
