/*
 *  Copyright 2016 Hyperz
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

.pragma library

var JSON_URL = "http://himawari8-dl.nict.go.jp/himawari8/img/D531106/latest.json";
var FETCH_URL = "http://himawari8.nict.go.jp/img/D531106/";

function getOptimalDetailLevel(width, height, imgSize) {

    var size = Math.max(Math.min(width, height), imgSize);

    if (size <= imgSize) {

        return 1;

    }

    var div = size / imgSize;
    var nearest = Math.pow(2, Math.round(Math.log(div) / Math.log(2)));
    var optimalDetailLevel = (nearest > 20) ? 20 : Math.max(nearest, 1);

    return optimalDetailLevel; // Possible values: 1, 2, 4, 8, 16, 20

}

function generateImageUrl(detailLevel, imgSize, dateTime, x, y) {

    return FETCH_URL + detailLevel + "d/" + imgSize + "/" + dateTime + "_" + x + "_" + y + ".png";

}

function getLatest(detailLevel, imgSize, callback) {

    var req = new XMLHttpRequest();

    req.onreadystatechange = function() {

        if (req.readyState === XMLHttpRequest.DONE) {

            console.debug("getJson:", req.responseText);

            var latest = JSON.parse(req.responseText);
            var dateTime = latest["date"].replace(/[\- ]/g, "/").replace(/:/g, "");
            var urls = [];

            for (var y = 0; y < detailLevel; y++) {

                for (var x = 0; x < detailLevel; x++) {

                    urls[(y * detailLevel) + x] = generateImageUrl(detailLevel, imgSize, dateTime, x, y);

                }

            }

            console.debug("URL's:", urls);
            callback(urls);

        }

    }

    req.onerror = function() {

        console.debug("HTTP error:", JSON_URL);

    }

    req.open("GET", JSON_URL, true);
    req.send();

}
