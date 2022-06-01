const { expext, expect } = require("chai")
const { erhers } = require("hardhat")

describe("Payments", function () {
    let acc1
    let acc2
    let payments
    
    // перед тестированием - выполняем развертывание контракта в блокчейне
    // beforeEach() выполняется перед каждым тестом
    beforeEach(async function() {
        // разворачивание контракта от имени тестового hardhat аккаунта
        [acc1, acc2] = await ethers.getSigners() 

        // получить информацию о скомпелированной версии контракта
        const Payments = await ethers.getContractFactory("Payments", acc1)

        // payments объект для взаимодействия с контрактом
        // отправка транзакции
        payments = await Payments.deploy()
        
        // дожидаемся завершения транзакции
        await payments.deployed()

        // отобразить адрес контракта после разворачивания
        // console.log(payments.address)
    })

    // тест 1
    // простой тест, что адрес контракта соответствут сам себе
    it("should be deployed", async function() {
        // console.log(payments.address)
        expect(payments.address).to.be.properAddress
    })
    
    it("should have 0 ether by default", async function() {
        const balance = await payments.currentBalance()
        expect(balance).to.eq(0)
    })
    
    it("should be possible to send funds", async function() {
        const amount = 100;
        const msg = "my message"
        // connect - указываем от имени какого аккаунта выполняется операция (по-умолчанию от первого аккаунта)
        const tx = await payments.connect(acc2).pay(msg, { value: amount })
        
        await expect(() => tx)
        .to.changeEtherBalance(acc2, -amount)
        
        // or 
        await expect(() => tx)
        .to.changeEtherBalances([acc2, payments], [-amount, amount])
        
        await tx.wait()
        
        // const balance = await payments.currentBalance()
        // expect(balance).to.eq(100)
        // console.log(balance)

        // информация о платеже
        const newPayment = await payments.getPayment(acc2.address, 0)
        // после вызова getPayment() не требуется .wait() т.к. это происходит через вызов, а не через транзакцию
        
        // console.log(newPayment)

        expect(newPayment.message).to.eq(msg)
        expect(newPayment.amount).to.eq(amount)
        expect(newPayment.from).to.eq(acc2.address)
    })

    it("should be possible to withdraw all funds from contract to caller ballance", async function() {
        const amount = 100;
        const tx1 = await payments.connect(acc2).pay("first payment", { value: amount })
        const tx2 = await payments.connect(acc2).pay("second payment", { value: amount })
        
        let balance = await payments.currentBalance()
        expect(balance).to.eq(amount * 2)

        payments.withdrawAll()

        balance = await payments.currentBalance()
        expect(balance).to.eq(0)
    })
})