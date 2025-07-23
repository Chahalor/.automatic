function replaceWithImage(selector, imageUrl) {
	const el = document.querySelector(selector);
	if (!el) return;

	// Récupère la taille de l'élément
	const rect = el.getBoundingClientRect();
	const width = rect.width + "px";
	const height = rect.height + "px";

	// Crée l'image
	const img = document.createElement("img");
	img.src = imageUrl;
	img.style.width = width;
	img.style.height = height;
	img.style.objectFit = "cover";
	img.style.display = "block";

	// Remplace l'élément dans le DOM
	el.parentNode.replaceChild(img, el);

	console.log(`You really thought you could TIG me?`);
}

replaceWithImage(".shop-item", "https://media.tenor.com/kkkBm71bkRcAAAAi/trollface-troll-face-terror-png.gif");