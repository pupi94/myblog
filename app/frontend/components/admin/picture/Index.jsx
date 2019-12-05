import React from 'react'
import {Link, Route} from "react-router-dom";
import {Button, Card, Icon, Pagination} from 'antd';
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
    showTotal = (total) => {
        return <span>{total} 条记录</span>;
    };

    render() {
        let pictures = [
            {
                src: "https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png",
                title: "JiqGstEfoWAOHiTxclqi.png",
            },
            {
                src: "https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png",
                title: "QBnOOoLaAfKPirc.png",
            },
            {
                src: "https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png",
                title: "JiqGstEfoWAOHiTxclqi.png",
            },
            {
                src: "https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png",
                title: "QBnOOoLaAfKPirc.png",
            },
            {
                src: "https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png",
                title: "QBnOOoLaAfKPirc.png",
            },
            {
                src: "https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png",
                title: "JiqGstEfoWAOHiTxclqi.png",
            },
            {
                src: "https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png",
                title: "QBnOOoLaAfKPirc.png",
            },
            {
                src: "https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png",
                title: "QBnOOoLaAfKPirc.png",
            },
            {
                src: "https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png",
                title: "QBnOOoLaAfKPirc.png",
            },
            {
                src: "https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png",
                title: "JiqGstEfoWAOHiTxclqi.png",
            },
            {
                src: "https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png",
                title: "QBnOOoLaAfKPirc.png",
            },
            {
                src: "https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png",
                title: "QBnOOoLaAfKPirc.png",
            },
            {
                src: "https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png",
                title: "JiqGstEfoWAOHiTxclqi.png",
            }
        ];

        return (
          <div className="index-page">
              <div style={{display: 'flex', flexWrap: 'wrap', flexDirection: 'row', alignContent: 'flex-start'}}>
                  {
                      pictures.map( (picture, idx) => (
                        <Card
                          key={idx}
                          hoverable={true}
                          style={{ margin: 10 }}
                          cover={ <img style={{height: 200, width:300}} alt="example" src={picture.src} /> }
                          actions={[<Icon type="delete" onClick={this.deleteRecord} />]} >

                            <Meta description={picture.title} />
                        </Card>
                      ))
                  }
              </div>
              <div style={{textAlign: 'center', marginTop: 15}}>
                  <Pagination defaultCurrent={1} total={50} showTotal={this.showTotal} />
              </div>

          </div>
        )
    }
}

export default Index;
