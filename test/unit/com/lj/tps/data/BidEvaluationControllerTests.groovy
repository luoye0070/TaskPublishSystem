package com.lj.tps.data



import org.junit.*
import grails.test.mixin.*

@TestFor(BidEvaluationController)
@Mock(BidEvaluation)
class BidEvaluationControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/bidEvaluation/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.bidEvaluationInstanceList.size() == 0
        assert model.bidEvaluationInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.bidEvaluationInstance != null
    }

    void testSave() {
        controller.save()

        assert model.bidEvaluationInstance != null
        assert view == '/bidEvaluation/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/bidEvaluation/show/1'
        assert controller.flash.message != null
        assert BidEvaluation.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/bidEvaluation/list'

        populateValidParams(params)
        def bidEvaluation = new BidEvaluation(params)

        assert bidEvaluation.save() != null

        params.id = bidEvaluation.id

        def model = controller.show()

        assert model.bidEvaluationInstance == bidEvaluation
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/bidEvaluation/list'

        populateValidParams(params)
        def bidEvaluation = new BidEvaluation(params)

        assert bidEvaluation.save() != null

        params.id = bidEvaluation.id

        def model = controller.edit()

        assert model.bidEvaluationInstance == bidEvaluation
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/bidEvaluation/list'

        response.reset()

        populateValidParams(params)
        def bidEvaluation = new BidEvaluation(params)

        assert bidEvaluation.save() != null

        // test invalid parameters in update
        params.id = bidEvaluation.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/bidEvaluation/edit"
        assert model.bidEvaluationInstance != null

        bidEvaluation.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/bidEvaluation/show/$bidEvaluation.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        bidEvaluation.clearErrors()

        populateValidParams(params)
        params.id = bidEvaluation.id
        params.version = -1
        controller.update()

        assert view == "/bidEvaluation/edit"
        assert model.bidEvaluationInstance != null
        assert model.bidEvaluationInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/bidEvaluation/list'

        response.reset()

        populateValidParams(params)
        def bidEvaluation = new BidEvaluation(params)

        assert bidEvaluation.save() != null
        assert BidEvaluation.count() == 1

        params.id = bidEvaluation.id

        controller.delete()

        assert BidEvaluation.count() == 0
        assert BidEvaluation.get(bidEvaluation.id) == null
        assert response.redirectedUrl == '/bidEvaluation/list'
    }
}
