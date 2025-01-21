document.addEventListener('DOMContentLoaded', () => {
    const submitCommentButton = document.getElementById('submit-comment');
    if (submitCommentButton) {
      submitCommentButton.addEventListener('click', () => {
        const postId = submitCommentButton.getAttribute('data-post-id');
        const content = document.getElementById('new-comment-content').value.trim();
  
        if (content === "") {
          alert("Comment cannot be empty.");
          return;
        }
  
        fetch(`/objave/${postId}/komentari/`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
          },
          body: JSON.stringify({ comment: { content: content } }),
        })
          .then((response) => {
            if (!response.ok) throw new Error('Failed to create comment');
            return response.text();
          })
          .then((html) => {
            document.getElementById('comments').innerHTML = html;
            document.getElementById('new-comment-content').value = '';
          })
          .catch((error) => console.error(error));
      });
    }
  
    document.getElementById('comments').addEventListener('click', (event) => {
      if (event.target.classList.contains('delete-comment')) {
        const commentId = event.target.getAttribute('data-comment-id');
        const postId = event.target.getAttribute('data-post-id');
  
        fetch(`/objave/${postId}/komentari/${commentId}`, {
          method: 'DELETE',
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
          },
        })
          .then((response) => {
            if (!response.ok) throw new Error('Failed to delete comment');
            return response.text();
          })
          .then((html) => {
            document.getElementById('comments').innerHTML = html;
          })
          .catch((error) => console.error(error));
      }
    });
  });
  