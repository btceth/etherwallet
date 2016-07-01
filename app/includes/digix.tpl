<!-- Digix -->
<div class="tab-pane active" ng-if="globalService.currentTab==globalService.tabs.digix.id">
  <h2> Digix </h2>
  <p><strong>Claim提取</strong> and和 <strong> Send 发送 </strong> your DigixDAO (DGD) tokens & badges DigixDAO(DGD）代币。. In order to claim, you must have participated in the token sale on March 30th/31st.只有参加了3月30/31日众筹的用户才能提取DGD代币。</p>

  @@if (site === 'cx' ) {
    <cx-wallet-decrypt-drtv></cx-wallet-decrypt-drtv>
  }
  @@if (site === 'mew' ) {
    <wallet-decrypt-drtv></wallet-decrypt-drtv>
  }

  <section class="row" ng-show="wallet!=null" ng-controller='digixCtrl'>
    <hr />

    <!-- Account Information - Left Column -->
    <section class="col-sm-4">
      <h4> Account Information账户信息 </h4>
      <div id="addressIdenticon" title="Address Indenticon" blockie-address="{{wallet.getAddressString()}}" watch-var="wallet"></div>
      <br />
      <p>
        Account Address:账户地址： <br />
        <strong style="padding-left: 1em; display: block;" class="mono word-wrap">{{wallet.getChecksumAddressString()}}</strong>
      </p>
      <p>
        Account Balance:账户余额： <br />
        <strong class="text-success" style="margin-left: 1em"> {{etherBalance}} Ether 以太币 </strong> <br />
        <strong class="text-success" style="margin-left: 1em"> {{usdBalance}} USD 美元</strong> <br />
        <strong class="text-success"  style="margin-left: 1em"> {{eurBalance}} EUR 欧元</strong> <br />
        <strong class="text-success" style="margin-left: 1em"> {{btcBalance}} BTC 比特币</strong>
      </p>
      <p> DGD Tokens:DGD代币 <br />
        <strong style="margin-left: 1em"> {{tokenBalance}} DGD </strong>
      </p>
      <p> DGD Badges: <br />
        <strong style="margin-left: 1em"> {{badgeBalance}} DGDb  </strong>
      </p>
      <p> DGD Crowdsale Information:DGD众筹信息： <br />
        <strong style="margin-left: 1em"> Centstotal: {{centsTotal}} </strong><br />
        <strong style="margin-left: 1em"> Weitotal: {{weiTotal}} </strong><br />
        <strong  style="margin-left: 1em"> Share: {{shareTotal}} </strong><br />
        <strong style="margin-left: 1em"> Badges: {{badgesTotal}} </strong><br />
        <strong style="margin-left: 1em"> Claimed? {{claimedTotal}} </strong>
      </p>
      <br />
    </section>
    <!-- Account Information - Left Column -->


    <!-- Claim / Send Information - Right Column -->
    <section class="col-sm-8 digix-send">

      <article class="btn-group">
        <a class="btn btn-primary" ng-class="{active: showSend}" ng-click="showSend=true"> Send your DGD Tokens or Badges </a>
        <a class="btn btn-primary" ng-class="{active: !showSend}" ng-click="showSend=false"> Claim your DGD Tokens </a>
      </article>

      <!-- Send Tokens Interface -->
      <article ng-show="showSend">
        <h4> Send Your DGD Tokens or Badges 发送你的DGD代币或者DGD勋章</h4>
        <div class="form-group col-xs-10">
          <label> To Address: </label>
          <input class="form-control" type="text" placeholder="0x7cB57B5A97eAbe94205C07890BE4c1aD31E486A8" ng-model="tokenTx.to" ng-change="validateAddress(tokenTx.to,'validateAddressStatus')"/>
          <div ng-bind-html="validateAddressStatus"></div>
        </div>
        <div class="col-xs-2 address-identicon-container">
          <div id="addressIdenticon" title="Address Indenticon" blockie-address="{{tokenTx.to}}" watch-var="tokenTx.to"></div>
        </div>
        <div class="form-group col-xs-12">
          <label>Amount to Send:发送数额：</label><br />
          <input class="form-control" type="text" placeholder="Amount" ng-model="tokenTx.value"/>
          <div class="radio">
            <label><input type="radio" name="tokenRadio" value="dgd" ng-model="tokenTx.unit"/>DGD Tokens</label>
            <label><input type="radio" name="tokenRadio" value="dgdb" ng-model="tokenTx.unit"/>DGD Badges</label>
          </div>
          <div class="form-group">
            <label> Gas: </label>
            <input class="form-control" type="text" ng-model="tx.gasLimit"/>
          </div>
        </div>
        <div class="form-group col-xs-12">
          <a class="btn btn-info btn-block" ng-click="generateTokenTx()">GENERATE TRANSACTION生成交易</a>
        </div>
      </article>
      <!-- / Send Tokens Interface -->

      <!-- Claim Interface -->
      <article ng-show="!showSend">
        <h4> Claim Your DGD Tokens 提取DGD代币</h4>
        <div class="form-group col-xs-12">
          <label>Estimated fee consumption:预计需要的交易费用：</label><br />
          <input class="form-control disabled" type="text" value="0.00043598 ether (21,799 gas)" readonly />
        </div>
       <div class="form-group col-xs-12">
          <label>Provided Maximum Fee:</label><br />
          <input class="form-control disabled" type="text" value="0.00243598 ether (121,799 gas)" readonly />
        </div>
       <div class="form-group col-xs-12">
          <label>Gas Price:</label><br />
          <input class="form-control disabled" type="text" value="0.021 ether per million gas" readonly />
        </div>
       <div class="form-group col-xs-12">
          <label>Data:</label><br />
          <input class="form-control disabled" type="text" readonly ng-model="tx.data"/>
        </div>
        <div class="form-group col-xs-12">
          <a class="btn btn-info btn-block" ng-click="generateTx()">GENERATE CLAIM</a>
        </div>
      </article>
      <!-- / Claim Interface -->

      <!-- raw transaction / buttons -->
      <div class="col-xs-12">
         <div ng-bind-html="validateTxStatus"></div>
      </div>
      <div class="form-group col-xs-12" ng-show="showRaw">
        <label> Raw Transaction </label>
        <textarea class="form-control" rows="4" disabled >{{rawTx}}</textarea>
        <label> Signed Transaction </label>
        <textarea class="form-control" rows="4" disabled >{{signedTx}}</textarea>
      </div>
      <div class="form-group col-xs-12" ng-show="showRaw">
        <a class="btn btn-primary btn-block" data-toggle="modal" data-target="#sendTransaction">EXECUTE TRANSACTION执行交易</a>
      </div>
      <div class="form-group col-xs-12" ng-bind-html="sendTxStatus"></div>
      <!-- / raw transaction / buttons -->
    </section>
  <!-- Modal -->
  <section class="modal fade" id="sendTransaction" tabindex="-1" role="dialog" aria-labelledby="sendTransactionLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h3 class="modal-title" id="myModalLabel"> <strong class="text-danger">Warning!警告！</strong></h3>
        </div>
        <div class="modal-body">
          <h4>
            You are about to send
            <strong id="confirmAmount" class="text-primary"> {{tokenTx.value}} </strong>
            <strong id="confirmCurrancy" class="text-primary"> {{tokenTx.unit}} </strong>
            to address
            <strong id="confirmAddress" class="text-primary"> {{tokenTx.to}} </strong>
          </h4>
          <h4> Are you <span class="text-underline"> sure </span> you want to do this?</h4>
        </div>
        <div class="modal-footer text-center">
          <button type="button" class="btn btn-default" data-dismiss="modal">No, get me out of here!不，停止发送交易。</button>
          <button type="button" class="btn btn-primary" ng-click="sendTx()">Yes, I am sure! Execute transaction.是的，确定！发送交易。</button>
        </div>
      </div>
    </div>
  </section>
  <!--/ Modal -->
  </section>

</div>
<!-- / Digix -->
