function StrongForce__receiveStateUpdateFromNative(result){
  const updated = JSON.parse(result)
  window.store.dispatch({type: "CONTRACT_STATE", contract: {address: updated.address,state: updated.state}})
}

function StrongForce__receiveQueryResponseFromNative(result){
  const data = JSON.parse(result)
  if(data.result){
    const url = data.query.url.split('/')
    const type = url[2];
    switch(type){
      case "state":{
        const address = url[3]
        window.store.dispatch({type: "CONTRACT_STATE", contract: {address,state: data.result}})
        break;
      }
      default: break;
    }
  }
}
  
function StrongForce__snackbarNotification(result){
  window.store.dispatch({
    type: "OPEN",
    snackbar: {open: false, type: "info", message: "Action sent to Blockchain"}
  })
}