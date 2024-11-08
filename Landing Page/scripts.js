document.getElementById('arcade-btn').addEventListener('click', function() {
    document.getElementById('arcade-images').style.display = 'block';
    document.getElementById('vs-images').style.display = 'none';
});

document.getElementById('vs-btn').addEventListener('click', function() {
    document.getElementById('vs-images').style.display = 'block';
    document.getElementById('arcade-images').style.display = 'none';
});
