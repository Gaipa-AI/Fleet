page 50037 "All General Requisitions"
{
    Caption = 'All General Requisitions';
    CardPageID = "General Requisition";
    DataCaptionFields = "Document Type";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "ADT Requisition Header";
    SourceTableView = WHERE("Document Type" = FILTER("Purchase Requisition"), "Request Type" = filter(General));
    Permissions = tabledata "ADT Requisition Header" = rim,
                      tabledata "ADT Requisition Line" = rm,
                      tabledata "Email Related Attachment" = rm;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Request-By Name"; Rec."Request-By Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                    ApplicationArea = All;
                }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Visible = false;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Requestor ID"; Rec."Requestor ID")
                {
                    Caption = 'Registered By';
                    ApplicationArea = All;
                }
                field("Release date"; Rec."Release date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    begin
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::"Purchase Requisition":
                                PAGE.RUN(PAGE::"Purchase Order", Rec);

                        END;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Purchase Requisition"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action("Print PP Form 20")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    var
                        ReqnHeader: Record "ADT Requisition Header";
                        RptPurchaseReqn: Report "Purchase Requisition";
                    begin
                        ReqnHeader.SETRANGE("Document Type", ReqnHeader."Document Type"::"Purchase Requisition");
                        ReqnHeader.SETRANGE("No.", Rec."No.");
                        RptPurchaseReqn.SETTABLEVIEW(ReqnHeader);
                        RptPurchaseReqn.RUNMODAL;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    var
    begin
    end;

    trigger OnOpenPage();
    begin
        Rec.SETRANGE("Document Type", Rec."Document Type"::"Purchase Requisition");

        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        UserMgt: Codeunit "User Setup Management";
}

