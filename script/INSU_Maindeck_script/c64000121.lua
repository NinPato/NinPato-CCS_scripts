--Unpossessed
function c64000121.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,64000121)
	e2:SetCondition(c64000121.condition)
	e2:SetTarget(c64000121.target)
	e2:SetOperation(c64000121.operation)
	c:RegisterEffect(e2)
	--Activate(summon)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c64000121.target2)
	e3:SetCountLimit(1,64000122)
	e3:SetCondition(c64000121.con)
	e3:SetOperation(c64000121.activate)
	c:RegisterEffect(e3)
end
function c64000121.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xc0)
end
function c64000121.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c64000121.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c64000121.filter(c)
	return c:GetAttack()==1500 and c:GetDefense()==200 and c:IsAbleToHand()
end
function c64000121.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64000121.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c64000121.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c64000121.filter),tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
	end
end

function c64000121.kfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xc0) and c:IsPreviousLocation(LOCATION_DECK)
end
function c64000121.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c64000121.kfilter,1,nil,tp)
end

function c64000121.nfilter(c)
	return c:IsCode(6540606) or c:IsCode(79333300) or c:IsCode(5037726) or c:IsCode(42945701) or c:IsCode(70156997) or c:IsSetCard(0x4d)
end
function c64000121.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64000121.nfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c64000121.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c64000121.nfilter),tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
	end
end
