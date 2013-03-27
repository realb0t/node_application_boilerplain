define [ 'require' ], (require) ->
  describe 'Examples', ->

    beforeEach -> 
      console.log('before is happening')

    describe 'Array#indexOf()', ->
      it 'should return -1 when the value is not present', ->
        [1,2,3].indexOf(5).should.to.equal(-1)
        [1,2,3].indexOf(0).should.to.equal(-1)

    describe 'Sinon with Chai.JS assertions', ->

      object = {}

      beforeEach -> 
        object = method: ->
        spy = sinon.spy(object, "method")

      it 'spy method must called', ->
        object.method()
        object.method.should.have.been.called

      it 'spy method must don\'t called', -> 
        object.method.should.have.not.been.called