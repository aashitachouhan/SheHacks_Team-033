// getting data
db.collection('fitbit').get().then(snapshot => {
        snapshot.docs.forEach(doc => {
            console.log(doc.data().current);
        });
    }); 