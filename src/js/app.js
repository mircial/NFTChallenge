App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    return await App.initWeb3();
  },
  initWeb3: async function() {
    // Modern dapp browsers...
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);
    return App.initContract();
  },

  initContract: function() {
    $.getJSON('NFTChallengeFactory.json', function(data) {
      App.contracts.NFTChallengeFactory = TruffleContract(data);
      // Set the provider for our contract
      App.contracts.NFTChallengeFactory.setProvider(App.web3Provider);  
    });   
    return App.bindEvents();
  },

  bindEvents: function() {
    $('#exampleModal').on('click',App.handleCreateItem);
  },

  handleCreateItem: async function(event) {
    event.preventDefault();
    
    var item_name = await $('#item_name').val();
    var manager = await $('#manager').val();
    var url = await $('#url').val();
    
    $('#create').off('click');
    $('#create').on('click', function(event){
      event.preventDefault();
    
      web3.eth.getAccounts(function(error, accounts) {
        if (error) {
          console.log(error);
        };
        // console.log(accounts[0]);
        App.contracts.NFTChallengeFactory.deployed().then(function(instance) {
          return instance.createItem(manager,{from: accounts[0]});
        }).then(async function(result){
          var mana = manager.substr(0, 6) + '...'+ manager.substr(38, 42);
          await $('#item-name').text(item_name);
          await $('#item1').find('.mana').text(mana);
          await $('#item1').find('.time').text('Sep - 15 - 2021');
          await $('#link_url').attr('href',url);
          await $('#link_url').text(url);
        }).catch(function(err) {
          console.log(err.messager);
        });
        });
    });

    },
  
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
