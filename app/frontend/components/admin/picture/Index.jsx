import React from 'react'
import { Link } from "react-router-dom";
import {Button, Card, Icon} from 'antd';
import ajax from "../../utils/Request"
const { Meta } = Card;

class Index extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    componentDidMount() {
    }

    deleteRecord = (e) => {
        console.log(e.currentTarget);
        console.log(e)
    };

    render() {
        return (
          <div>
              <div className="table-operations">
                  <Link to={"/admin/pictures/new"} style={{float: 'right' }}>
                      <Button type="primary">创建</Button>
                  </Link>
              </div>
              <div style={{display: 'flex', flexWrap: 'wrap', flexDirection: 'row'}}>
                  <Card
                    style={{ width: 300, padding: '5' }}
                    cover={<img alt="example" src="https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png"/>}
                    actions={[<Icon type="delete" key="delete" id={'2'} onClick={this.deleteRecord} />]}
                  >
                      <Meta description="This is the description"/>
                  </Card>
              </div>
          </div>
        )
    }
}

export default Index;
