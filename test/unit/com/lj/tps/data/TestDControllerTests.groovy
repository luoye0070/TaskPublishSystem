package com.lj.tps.data



import org.junit.*
import grails.test.mixin.*

@TestFor(TestDController)
@Mock(TestD)
class TestDControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/testD/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.testDInstanceList.size() == 0
        assert model.testDInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.testDInstance != null
    }

    void testSave() {
        controller.save()

        assert model.testDInstance != null
        assert view == '/testD/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/testD/show/1'
        assert controller.flash.message != null
        assert TestD.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/testD/list'

        populateValidParams(params)
        def testD = new TestD(params)

        assert testD.save() != null

        params.id = testD.id

        def model = controller.show()

        assert model.testDInstance == testD
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/testD/list'

        populateValidParams(params)
        def testD = new TestD(params)

        assert testD.save() != null

        params.id = testD.id

        def model = controller.edit()

        assert model.testDInstance == testD
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/testD/list'

        response.reset()

        populateValidParams(params)
        def testD = new TestD(params)

        assert testD.save() != null

        // test invalid parameters in update
        params.id = testD.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/testD/edit"
        assert model.testDInstance != null

        testD.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/testD/show/$testD.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        testD.clearErrors()

        populateValidParams(params)
        params.id = testD.id
        params.version = -1
        controller.update()

        assert view == "/testD/edit"
        assert model.testDInstance != null
        assert model.testDInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/testD/list'

        response.reset()

        populateValidParams(params)
        def testD = new TestD(params)

        assert testD.save() != null
        assert TestD.count() == 1

        params.id = testD.id

        controller.delete()

        assert TestD.count() == 0
        assert TestD.get(testD.id) == null
        assert response.redirectedUrl == '/testD/list'
    }
}
