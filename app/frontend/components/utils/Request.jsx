import React from 'react'
import { message } from 'antd';

class Request {
    get = (url, options = {}) => {
        let opts = { method: "GET" };

        let queryString = this._objToQueryString(options.data);
        if(queryString !== ""){
            url = `${url}?${queryString}`
        }

        return this._request(url, opts)
    };

    post = (url, options = {}) => {
        let opts = {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
        };
        if(options.headers){
            opts.headers = this._mergeHeaders(opts.headers, options.headers)
        }
        if(options.data) {
            opts.body = JSON.stringify(options.data)
        }
        return this._request(url, opts)
    };

    delete = (url, options = {}) => {
        let opts = {
            method: "DELETE",
            headers: {
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            }
        };
        if(options.headers){
            opts.headers = this._mergeHeaders(opts.headers, options.headers)
        }

        return this._request(url, opts)
    };

    put = (url, options = {}) =>{
        let opts = {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
        };

        if(options.headers){
            opts.headers = this._mergeHeaders(opts.headers, options.headers)
        }
        if(options.data) {
            opts.body = JSON.stringify(options.data)
        }
        return this._request(url, opts)
    };

    patch = (url, options = {}) =>{
        let opts = {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
        };

        if(options.headers){
            opts.headers = this._mergeHeaders(opts.headers, options.headers)
        }
        if(options.data) {
            opts.body = JSON.stringify(options.data)
        }
        return this._request(url, opts)
    };

    _request = (url, opts) => {
        return fetch(url, opts)
          .then(response => {
              if(response.status === 204){
                  return response
              }else if(response.status === 200){
                  return response.json()
              }else if(response.status >= 400 && response.status <= 500){
                  message.error(response.statusText);
                  throw new Error(response.statusText);
              }else {
                  message.error("系统异常！");
                  throw new Error(response.statusText)
              }
          }).catch((error) => {
              message.error("网络异常");
              throw error
          })
    };

    _objToQueryString = (obj = {}) => {
        const ary = [];
        for (const key in obj) {
            ary.push(encodeURIComponent(key) + '=' + encodeURIComponent(obj[key]));
        }
        return ary.join('&');
    };

    _mergeHeaders = (headers1, headers2) => {
        for(let attr in headers2){
            headers1[attr] = headers2[attr];
        }
        return headers1;
    };
}
const ajax = new Request();
export default ajax;
