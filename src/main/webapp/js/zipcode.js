function findZipcode() {
		url = "findZipcode.do";
		window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
	}
	
	//이미지 업로드시 이미지를 볼 수 있게 해준다.
	function imageViewer(id, viewer) {
		
		var upload = document.getElementById(id)
		var viewDiv = document.getElementById(viewer)
		
		upload.onchange = function(e) {
			
			e.preventDefault();
			
			var file = upload.files[0], 
			reader = new FileReader();
			
			reader.onload = function(event) {
				var img = new Image();
				img.src = event.target.result;
				img.width = 300;
				viewDiv.innerHTML = '';
				viewDiv.appendChild(img);
			};
			
			reader.readAsDataURL(file);
	
			return false;
		};
		
	}
