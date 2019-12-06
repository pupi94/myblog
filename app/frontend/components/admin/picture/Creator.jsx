import React from 'react'
import {Upload, Button, Icon} from "antd";

class Creator extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    render() {
        const fileList = [
            {
                uid: '-1',
                name: 'xxx.png',
                status: 'done',
                url: 'https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png',
                thumbUrl: 'https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png',
            },
            {
                uid: '-2',
                name: 'yyy.png',
                status: 'error',
            },
            {
                uid: '-3',
                name: 'yyy.png',
                status: 'error',
            },
        ];

        const props = {
            action: 'https://www.mocky.io/v2/5cc8019d300000980a055e76',
            listType: 'picture',
            multiple: true,
            defaultFileList: [...fileList],
            className: "picture-upload"
        };

        return (
          <div className='form-page' style={{minHeight: 600}}>
              <div style={{float: 'right'}}>
                  <Button type="primary" shape="round" size='large'><Icon type="save" />保存</Button>
              </div>

              <Upload {...props}>
                  <Button shape="round" size='large' style={{marginRight: 15}}><Icon type="upload" />上传</Button>
              </Upload>
          </div>
        )
    }
}

export default Creator;
