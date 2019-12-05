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
        ];

        const props = {
            action: 'https://www.mocky.io/v2/5cc8019d300000980a055e76',
            listType: 'picture',
            defaultFileList: [...fileList],
            className: 'upload-list-inline',
        };

        return (
          <div className='form-page' style={{minHeight: 600}}>
              <Upload {...props}>
                  <Button><Icon type="upload" /> Upload</Button>
              </Upload>
          </div>
        )
    }
}

export default Creator;
