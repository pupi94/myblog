import React from 'react'
import { message } from 'antd';

class Request {
    get(url, options = {}) {
        options.method = "GET";
        return fetch(url, options)
            .then(response => this._handleResponseStatue(response))
            .catch((error) => {
                throw error
            });
    }

    post(url, options = {}){

    }

    delete(url, options = {}){
        options.method = "DELETE";
        return fetch(url, options)
            .then(response => this._handleResponseStatue(response))
    }

    put(url, options = {}){

    }

    patch(url, options = {}){

    }

    _handleResponseStatue(response) {
        if(response.status == 204){
            return response
        }else if(response.status >= 200 && response.status < 300){
            return response.json()
        }else{
            message.error(response.statusText);
            throw new Error(response.statusText)
        }
    }
}
const ajax = new Request()
export default ajax;
