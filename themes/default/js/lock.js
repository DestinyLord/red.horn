var Lock = function () {

    return {
        //main function to initiate the module
        init: function () {

             $.backstretch([
		        imageUrl+"bg/1.jpg",
		        imageUrl+"bg/2.jpg",
		        imageUrl+"bg/3.jpg",
		        imageUrl+"bg/4.jpg"
		        ], {
		          fade: 1000,
		          duration: 8000
		      });
        }

    };

}();