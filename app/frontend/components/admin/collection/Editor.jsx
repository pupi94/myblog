import React from 'react'
import CollectionForm from "./Form"
import ajax from "../../utils/Request";
import {message} from "antd";

class Editor extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            collection: {}
        };
        this.id = props.match.params.id;
    }

    onSubmit = (collection) => {
        ajax.patch(`/api/admin/collections/${this.id}`, {
            data: { collection: collection }
        }).then(response => {
            this.props.history.push("/admin/collections");
            message.success("修改成功");
        })
    };

    render() {
        return <CollectionForm collectionId={ this.id } onSubmit={this.onSubmit} />
    }
}

export default Editor;
