import Nimble
import Quick

@testable import BaseProject

class HomeViewModelTest: QuickSpec {
    
    override class func spec() {
        var viewModel: HomeViewModel!
        
        describe("Test funcs homeScreen") {
            context("Test some funcs related to tableView") {
                beforeEach {
                    let repositoryMock = HomeRepositoryImplementationMock()
                    let useCaseMock = HomeUseCaseImplementation(repository: repositoryMock)
                    viewModel = HomeViewModel(useCase: useCaseMock)
                }
                it("Test func numberOfSection") {
                    expect(viewModel.numberOfSection()) == 1
                }
                it("Test func numberOfItem in section 0") {
                    expect(viewModel.numberOfRowInSection(in: 0)) == 0
                }
                it("Test func api with mock success") {
                    waitUntil(timeout: .seconds(1)) { done in
                        viewModel.getWorkouts { _ in
                            expect(viewModel.items.count) == 7
                            done()
                        }
                    }
                }
                it("Test func api with mock failure") {
                    waitUntil(timeout: .seconds(1)) { done in
                        viewModel.getWorkouts { _ in
                            expect(viewModel.items.count) == 7
                            done()
                        }
                    }
                }
                afterEach {
                    viewModel = nil
                }
            }
            
            context("Test some api failure") {
                beforeEach {
                    let repositoryMock = HomeRepositoryImplementationMockWithFailure()
                    let useCaseMock = HomeUseCaseImplementation(repository: repositoryMock)
                    viewModel = HomeViewModel(useCase: useCaseMock)
                }
                it("Test func numberOfSection") {
                    expect(viewModel.numberOfSection()) == 1
                }
                it("Test func numberOfItem in section 0") {
                    expect(viewModel.numberOfRowInSection(in: 0)) == 0
                }
                it("Test func api with mock failure") {
                    waitUntil(timeout: .seconds(1)) { done in
                        viewModel.getWorkouts { _ in
                            expect(viewModel.items.count) == 0
                            done()
                        }
                    }
                }
                afterEach {
                    viewModel = nil
                }
            }
        }
    }
}
