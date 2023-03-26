const mongoose = require('mongoose');

const loginSchema = mongoose.Schema({
    username: {
        type : String,
        unique: true,
        required:true
    },
    password: {
        type: String,
        required: true
    },
    logindate: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model("Login", loginSchema);