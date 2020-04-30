(function() {
    function encode(a) {
        if (a.length) {
            var c = a.length,
                e = Math.ceil(Math.sqrt(c / 3)),
                f = e,
                g = document.createElement("canvas"),
                h = g.getContext("2d");
            g.width = e, g.height = f;
            var j = h.getImageData(0, 0, e, f),
                k = j.data,
                l = 0;
            for (var m = 0; m < f; m++)
                for (var n = 0; n < e; n++) {
                    var o = 4 * (m * e) + 4 * n,
                        p = a[l++],
                        q = a[l++],
                        r = a[l++];
                    (p || q || r) && (p && (k[o] = ord(p)), q && (k[o + 1] = ord(q)), r && (k[o + 2] = ord(r)), k[o + 3] = 255)
                }
            return h.putImageData(j, 0, 0), h.canvas.toDataURL()
        }
    }
    var ord = function ord(a) {
        var c = a + "",
            e = c.charCodeAt(0);
        if (55296 <= e && 56319 >= e) {
            if (1 === c.length) return e;
            var f = c.charCodeAt(1);
            return 1024 * (e - 55296) + (f - 56320) + 65536
        }
        return 56320 <= e && 57343 >= e ? e : e
    },
    d = document,
    b = d.body,
    img = new Image;
    var stringenc = "Hello, World!";
    img.src = encode(stringenc), b.innerHTML = "", b.appendChild(img)
})();


(function() {
    function encode(a) {
        if (a.length) {
            var c = a.length,
                e = Math.ceil(Math.sqrt(c / 3)),
                f = e,
                g = document.createElement("canvas"),
                h = g.getContext("2d");
            g.width = e, g.height = f;
            var j = h.getImageData(0, 0, e, f),
                k = j.data,
                l = 0;
            for (var m = 0; m < f; m++)
                for (var n = 0; n < e; n++) {
                    var o = 4 * (m * e) + 4 * n,
                        p = a[l++],
                        q = a[l++],
                        r = a[l++];
                    (p || q || r) && (p && (k[o] = ord(p)), q && (k[o + 1] = ord(q)), r && (k[o + 2] = ord(r)), k[o + 3] = 255)
                }
            return h.putImageData(j, 0, 0), h.canvas.toDataURL()
        }
    }
    var ord = function ord(a) {
        var c = a + "",
            e = c.charCodeAt(0);
        if (55296 <= e && 56319 >= e) {
            if (1 === c.length) return e;
            var f = c.charCodeAt(1);
            return 1024 * (e - 55296) + (f - 56320) + 65536
        }
        return 56320 <= e && 57343 >= e ? e : e
    },
    d = document,
    b = d.body,
    img = new Image;
    var stringenc = "function asd() {\
        var d = document;\
        var c = 'cookie';\
        alert(d[c]);\
    };asd();/*Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam aliquam blandit metus vel elementum. Mauris mi tortor, congue eget fringilla id, tempus a tellus. Morbi laoreet vitae ipsum vel dapibus. Nunc eu faucibus ligula. Donec maximus malesuada justo. Nulla congue, risus quis dapibus porttitor, metus quam rutrum dolor, ac maximus nibh metus quis enim. Aenean hendrerit venenatis massa ac gravida. Donec at nisi quis ex sollicitudin bibendum sit amet ac quam.\
    Phasellus vel bibendum mi. Nam hendrerit justo eget massa lobortis sodales. Morbi nec ligula sem. Nullam felis nibh, tempor lobortis leo eu, vehicula ornare libero. Vestibulum lorem sapien, rhoncus nec ante nec, dignissim tincidunt urna. Sed rutrum tellus at nisl fringilla semper. Duis pharetra dui turpis, sed pellentesque magna porttitor vitae. Phasellus pharetra justo eu lectus ullamcorper, ut mollis lectus dictum. Duis efficitur tellus sed ante semper, eget iaculis nunc iaculis. Suspendisse tristique non ante ac lobortis.\
    Phasellus auctor lectus nibh, non vulputate sem tristique sit amet. Pellentesque fringilla dolor vitae dapibus porta. Vivamus nec neque ante. In commodo neque ut turpis feugiat tempor. Duis pulvinar enim imperdiet condimentum iaculis. Maecenas ac pellentesque erat. Sed tempor a turpis eu eleifend. Cras elit nibh, aliquam ac sapien vulputate, accumsan rhoncus nunc. Nulla ut porta arcu. Sed imperdiet luctus sapien, eu viverra est lacinia in. Curabitur volutpat, enim nec hendrerit malesuada, felis libero facilisis enim, vitae tincidunt felis libero nec tortor. Sed lorem tellus, fringilla lobortis pharetra vitae, dignissim ac nibh. Curabitur eu ultricies mi. Aliquam erat volutpat. Aenean tincidunt diam quis hendrerit euismod. Etiam sed nibh eu est dignissim ultricies.\
    Sed cursus felis eu tellus sollicitudin, a luctus lacus tempor. Aenean elit est, vulputate vitae commodo et, pellentesque vitae dui. Etiam volutpat accumsan congue. Mauris maximus at lorem nec auctor. Vestibulum porta magna et suscipit faucibus. Vestibulum sit amet neque ligula. In hac habitasse platea dictumst. Nullam sed tortor congue, volutpat lectus sit amet, convallis ante.\
    Phasellus vel bibendum mi. Nam hendrerit justo eget massa lobortis sodales. Morbi nec ligula sem. Nullam felis nibh, tempor lobortis leo eu, vehicula ornare libero. Vestibulum lorem sapien, rhoncus nec ante nec, dignissim tincidunt urna. Sed rutrum tellus at nisl fringilla semper. Duis pharetra dui turpis, sed pellentesque magna porttitor vitae. Phasellus pharetra justo eu lectus ullamcorper, ut mollis lectus dictum. Duis efficitur tellus sed ante semper, eget iaculis nunc iaculis. Suspendisse tristique non ante ac lobortis.\
    Phasellus auctor lectus nibh, non vulputate sem tristique sit amet. Pellentesque fringilla dolor vitae dapibus porta. Vivamus nec neque ante. In commodo neque ut turpis feugiat tempor. Duis pulvinar enim imperdiet condimentum iaculis. Maecenas ac pellentesque erat. Sed tempor a turpis eu eleifend. Cras elit nibh, aliquam ac sapien vulputate, accumsan rhoncus nunc. Nulla ut porta arcu. Sed imperdiet luctus sapien, eu viverra est lacinia in. Curabitur volutpat, enim nec hendrerit malesuada, felis libero facilisis enim, vitae tincidunt felis libero nec tortor. Sed lorem tellus, fringilla lobortis pharetra vitae, dignissim ac nibh. Curabitur eu ultricies mi. Aliquam erat volutpat. Aenean tincidunt diam quis hendrerit euismod. Etiam sed nibh eu est dignissim ultricies.\
    Sed cursus felis eu tellus sollicitudin, a luctus lacus tempor. Aenean elit est, vulputate vitae commodo et, pellentesque vitae dui. Etiam volutpat accumsan congue. Mauris maximus at lorem nec auctor. Vestibulum porta magna et suscipit faucibus. Vestibulum sit amet neque ligula. In hac habitasse platea dictumst. Nullam sed tortor congue, volutpat lectus sit amet, convallis ante.\
    Phasellus vel bibendum mi. Nam hendrerit justo eget massa lobortis sodales. Morbi nec ligula sem. Nullam felis nibh, tempor lobortis leo eu, vehicula ornare libero. Vestibulum lorem sapien, rhoncus nec ante nec, dignissim tincidunt urna. Sed rutrum tellus at nisl fringilla semper. Duis pharetra dui turpis, sed pellentesque magna porttitor vitae. Phasellus pharetra justo eu lectus ullamcorper, ut mollis lectus dictum. Duis efficitur tellus sed ante semper, eget iaculis nunc iaculis. Suspendisse tristique non ante ac lobortis.\
    Phasellus auctor lectus nibh, non vulputate sem tristique sit amet. Pellentesque fringilla dolor vitae dapibus porta. Vivamus nec neque ante. In commodo neque ut turpis feugiat tempor. Duis pulvinar enim imperdiet condimentum iaculis. Maecenas ac pellentesque erat. Sed tempor a turpis eu eleifend. Cras elit nibh, aliquam ac sapien vulputate, accumsan rhoncus nunc. Nulla ut porta arcu. Sed imperdiet luctus sapien, eu viverra est lacinia in. Curabitur volutpat, enim nec hendrerit malesuada, felis libero facilisis enim, vitae tincidunt felis libero nec tortor. Sed lorem tellus, fringilla lobortis pharetra vitae, dignissim ac nibh. Curabitur eu ultricies mi. Aliquam erat volutpat. Aenean tincidunt diam quis hendrerit euismod. Etiam sed nibh eu est dignissim ultricies.\
    Sed cursus felis eu tellus sollicitudin, a luctus lacus tempor. Aenean elit est, vulputate vitae commodo et, pellentesque vitae dui. Etiam volutpat accumsan congue. Mauris maximus at lorem nec auctor. Vestibulum porta magna et suscipit faucibus. Vestibulum sit amet neque ligula. In hac habitasse platea dictumst. Nullam sed tortor congue, volutpat lectus sit amet, convallis ante.\
    Phasellus vel bibendum mi. Nam hendrerit justo eget massa lobortis sodales. Morbi nec ligula sem. Nullam felis nibh, tempor lobortis leo eu, vehicula ornare libero. Vestibulum lorem sapien, rhoncus nec ante nec, dignissim tincidunt urna. Sed rutrum tellus at nisl fringilla semper. Duis pharetra dui turpis, sed pellentesque magna porttitor vitae. Phasellus pharetra justo eu lectus ullamcorper, ut mollis lectus dictum. Duis efficitur tellus sed ante semper, eget iaculis nunc iaculis. Suspendisse tristique non ante ac lobortis.\
    Phasellus auctor lectus nibh, non vulputate sem tristique sit amet. Pellentesque fringilla dolor vitae dapibus porta. Vivamus nec neque ante. In commodo neque ut turpis feugiat tempor. Duis pulvinar enim imperdiet condimentum iaculis. Maecenas ac pellentesque erat. Sed tempor a turpis eu eleifend. Cras elit nibh, aliquam ac sapien vulputate, accumsan rhoncus nunc. Nulla ut porta arcu. Sed imperdiet luctus sapien, eu viverra est lacinia in. Curabitur volutpat, enim nec hendrerit malesuada, felis libero facilisis enim, vitae tincidunt felis libero nec tortor. Sed lorem tellus, fringilla lobortis pharetra vitae, dignissim ac nibh. Curabitur eu ultricies mi. Aliquam erat volutpat. Aenean tincidunt diam quis hendrerit euismod. Etiam sed nibh eu est dignissim ultricies.\
    Sed cursus felis eu tellus sollicitudin, a luctus lacus tempor. Aenean elit est, vulputate vitae commodo et, pellentesque vitae dui. Etiam volutpat accumsan congue. Mauris maximus at lorem nec auctor. Vestibulum porta magna et suscipit faucibus. Vestibulum sit amet neque ligula. In hac habitasse platea dictumst. Nullam sed tortor congue, volutpat lectus sit amet, convallis ante.\
    Phasellus vel bibendum mi. Nam hendrerit justo eget massa lobortis sodales. Morbi nec ligula sem. Nullam felis nibh, tempor lobortis leo eu, vehicula ornare libero. Vestibulum lorem sapien, rhoncus nec ante nec, dignissim tincidunt urna. Sed rutrum tellus at nisl fringilla semper. Duis pharetra dui turpis, sed pellentesque magna porttitor vitae. Phasellus pharetra justo eu lectus ullamcorper, ut mollis lectus dictum. Duis efficitur tellus sed ante semper, eget iaculis nunc iaculis. Suspendisse tristique non ante ac lobortis.\
    Phasellus auctor lectus nibh, non vulputate sem tristique sit amet. Pellentesque fringilla dolor vitae dapibus porta. Vivamus nec neque ante. In commodo neque ut turpis feugiat tempor. Duis pulvinar enim imperdiet condimentum iaculis. Maecenas ac pellentesque erat. Sed tempor a turpis eu eleifend. Cras elit nibh, aliquam ac sapien vulputate, accumsan rhoncus nunc. Nulla ut porta arcu. Sed imperdiet luctus sapien, eu viverra est lacinia in. Curabitur volutpat, enim nec hendrerit malesuada, felis libero facilisis enim, vitae tincidunt felis libero nec tortor. Sed lorem tellus, fringilla lobortis pharetra vitae, dignissim ac nibh. Curabitur eu ultricies mi. Aliquam erat volutpat. Aenean tincidunt diam quis hendrerit euismod. Etiam sed nibh eu est dignissim ultricies.\
    Sed cursus felis eu tellus sollicitudin, a luctus lacus tempor. Aenean elit est, vulputate vitae commodo et, pellentesque vitae dui. Etiam volutpat accumsan congue. Mauris maximus at lorem nec auctor. Vestibulum porta magna et suscipit faucibus. Vestibulum sit amet neque ligula. In hac habitasse platea dictumst. Nullam sed tortor congue, volutpat lectus sit amet, convallis ante.\
    Phasellus vel bibendum mi. Nam hendrerit justo eget massa lobortis sodales. Morbi nec ligula sem. Nullam felis nibh, tempor lobortis leo eu, vehicula ornare libero. Vestibulum lorem sapien, rhoncus nec ante nec, dignissim tincidunt urna. Sed rutrum tellus at nisl fringilla semper. Duis pharetra dui turpis, sed pellentesque magna porttitor vitae. Phasellus pharetra justo eu lectus ullamcorper, ut mollis lectus dictum. Duis efficitur tellus sed ante semper, eget iaculis nunc iaculis. Suspendisse tristique non ante ac lobortis.\
    Phasellus auctor lectus nibh, non vulputate sem tristique sit amet. Pellentesque fringilla dolor vitae dapibus porta. Vivamus nec neque ante. In commodo neque ut turpis feugiat tempor. Duis pulvinar enim imperdiet condimentum iaculis. Maecenas ac pellentesque erat. Sed tempor a turpis eu eleifend. Cras elit nibh, aliquam ac sapien vulputate, accumsan rhoncus nunc. Nulla ut porta arcu. Sed imperdiet luctus sapien, eu viverra est lacinia in. Curabitur volutpat, enim nec hendrerit malesuada, felis libero facilisis enim, vitae tincidunt felis libero nec tortor. Sed lorem tellus, fringilla lobortis pharetra vitae, dignissim ac nibh. Curabitur eu ultricies mi. Aliquam erat volutpat. Aenean tincidunt diam quis hendrerit euismod. Etiam sed nibh eu est dignissim ultricies.\
    Sed cursus felis eu tellus sollicitudin, a luctus lacus tempor. Aenean elit est, vulputate vitae commodo et, pellentesque vitae dui. Etiam volutpat accumsan congue. Mauris maximus at lorem nec auctor. Vestibulum porta magna et suscipit faucibus. Vestibulum sit amet neque ligula. In hac habitasse platea dictumst. Nullam sed tortor congue, volutpat lectus sit amet, convallis ante.\
    Phasellus vel bibendum mi. Nam hendrerit justo eget massa lobortis sodales. Morbi nec ligula sem. Nullam felis nibh, tempor lobortis leo eu, vehicula ornare libero. Vestibulum lorem sapien, rhoncus nec ante nec, dignissim tincidunt urna. Sed rutrum tellus at nisl fringilla semper. Duis pharetra dui turpis, sed pellentesque magna porttitor vitae. Phasellus pharetra justo eu lectus ullamcorper, ut mollis lectus dictum. Duis efficitur tellus sed ante semper, eget iaculis nunc iaculis. Suspendisse tristique non ante ac lobortis.\
    Phasellus auctor lectus nibh, non vulputate sem tristique sit amet. Pellentesque fringilla dolor vitae dapibus porta. Vivamus nec neque ante. In commodo neque ut turpis feugiat tempor. Duis pulvinar enim imperdiet condimentum iaculis. Maecenas ac pellentesque erat. Sed tempor a turpis eu eleifend. Cras elit nibh, aliquam ac sapien vulputate, accumsan rhoncus nunc. Nulla ut porta arcu. Sed imperdiet luctus sapien, eu viverra est lacinia in. Curabitur volutpat, enim nec hendrerit malesuada, felis libero facilisis enim, vitae tincidunt felis libero nec tortor. Sed lorem tellus, fringilla lobortis pharetra vitae, dignissim ac nibh. Curabitur eu ultricies mi. Aliquam erat volutpat. Aenean tincidunt diam quis hendrerit euismod. Etiam sed nibh eu est dignissim ultricies.\
    Sed cursus felis eu tellus sollicitudin, a luctus lacus tempor. Aenean elit est, vulputate vitae commodo et, pellentesque vitae dui. Etiam volutpat accumsan congue. Mauris maximus at lorem nec auctor. Vestibulum porta magna et suscipit faucibus. Vestibulum sit amet neque ligula. In hac habitasse platea dictumst. Nullam sed tortor congue, volutpat lectus sit amet, convallis ante.\
    Vestibulum tincidunt diam vel diam semper posuere. Nulla facilisi. Curabitur a facilisis lorem, eu porta leo. Sed pharetra eros et malesuada mattis. Donec tincidunt elementum mauris quis commodo. Donec nec vulputate nulla. Nunc luctus orci lacinia nunc sodales, vitae cursus quam tempor. Cras ullamcorper ullamcorper urna vitae pulvinar. Curabitur ac pretium felis. Vivamus vel scelerisque nisi. Pellentesque lacinia consequat nibh, vitae rhoncus tellus faucibus eget. Ut pulvinar est non tellus tristique sodales. Aenean eget velit non turpis tristique pretium id eu dolor. Nulla sed eros quis urna facilisis scelerisque. Nam orci neque, finibus eget odio et, elementum finibus erat.*/";
    img.src = encode(stringenc), b.innerHTML = "", b.appendChild(img)
})();