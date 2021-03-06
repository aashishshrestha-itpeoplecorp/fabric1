// Code generated by protoc-gen-go.
// source: peer/fabric_transaction.proto
// DO NOT EDIT!

package peer

import proto "github.com/golang/protobuf/proto"
import fmt "fmt"
import math "math"
import google_protobuf "github.com/golang/protobuf/ptypes/timestamp"

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

type InvalidTransaction_Cause int32

const (
	InvalidTransaction_TxIdAlreadyExists      InvalidTransaction_Cause = 0
	InvalidTransaction_RWConflictDuringCommit InvalidTransaction_Cause = 1
)

var InvalidTransaction_Cause_name = map[int32]string{
	0: "TxIdAlreadyExists",
	1: "RWConflictDuringCommit",
}
var InvalidTransaction_Cause_value = map[string]int32{
	"TxIdAlreadyExists":      0,
	"RWConflictDuringCommit": 1,
}

func (x InvalidTransaction_Cause) String() string {
	return proto.EnumName(InvalidTransaction_Cause_name, int32(x))
}
func (InvalidTransaction_Cause) EnumDescriptor() ([]byte, []int) { return fileDescriptor11, []int{1, 0} }

// This message is necessary to facilitate the verification of the signature
// (in the signature field) over the bytes of the transaction (in the
// transactionBytes field).
type SignedTransaction struct {
	// The bytes of the Transaction. NDD
	TransactionBytes []byte `protobuf:"bytes,1,opt,name=transactionBytes,proto3" json:"transactionBytes,omitempty"`
	// Signature of the transactionBytes The public key of the signature is in
	// the header field of TransactionAction There might be multiple
	// TransactionAction, so multiple headers, but there should be same
	// transactor identity (cert) in all headers
	Signature []byte `protobuf:"bytes,2,opt,name=signature,proto3" json:"signature,omitempty"`
}

func (m *SignedTransaction) Reset()                    { *m = SignedTransaction{} }
func (m *SignedTransaction) String() string            { return proto.CompactTextString(m) }
func (*SignedTransaction) ProtoMessage()               {}
func (*SignedTransaction) Descriptor() ([]byte, []int) { return fileDescriptor11, []int{0} }

// This is used to wrap an invalid Transaction with the cause
type InvalidTransaction struct {
	Transaction *Transaction             `protobuf:"bytes,1,opt,name=transaction" json:"transaction,omitempty"`
	Cause       InvalidTransaction_Cause `protobuf:"varint,2,opt,name=cause,enum=protos.InvalidTransaction_Cause" json:"cause,omitempty"`
}

func (m *InvalidTransaction) Reset()                    { *m = InvalidTransaction{} }
func (m *InvalidTransaction) String() string            { return proto.CompactTextString(m) }
func (*InvalidTransaction) ProtoMessage()               {}
func (*InvalidTransaction) Descriptor() ([]byte, []int) { return fileDescriptor11, []int{1} }

func (m *InvalidTransaction) GetTransaction() *Transaction {
	if m != nil {
		return m.Transaction
	}
	return nil
}

// The transaction to be sent to the ordering service. A transaction contains
// one or more TransactionAction. Each TransactionAction binds a proposal to
// potentially multiple actions. The transaction is atomic meaning that either
// all actions in the transaction will be committed or none will.  Note that
// while a Transaction might include more than one Header, the Header.creator
// field must be the same in each.
// A single client is free to issue a number of independent Proposal, each with
// their header (Header) and request payload (ChaincodeProposalPayload).  Each
// proposal is independently endorsed generating an action
// (ProposalResponsePayload) with one signature per Endorser. Any number of
// independent proposals (and their action) might be included in a transaction
// to ensure that they are treated atomically.
type Transaction struct {
	// Version indicates message protocol version.
	Version int32 `protobuf:"varint,1,opt,name=version" json:"version,omitempty"`
	// Timestamp is the local time that the
	// message was created by the sender
	Timestamp *google_protobuf.Timestamp `protobuf:"bytes,2,opt,name=timestamp" json:"timestamp,omitempty"`
	// The payload is an array of TransactionAction. An array is necessary to
	// accommodate multiple actions per transaction
	Actions []*TransactionAction `protobuf:"bytes,3,rep,name=actions" json:"actions,omitempty"`
}

func (m *Transaction) Reset()                    { *m = Transaction{} }
func (m *Transaction) String() string            { return proto.CompactTextString(m) }
func (*Transaction) ProtoMessage()               {}
func (*Transaction) Descriptor() ([]byte, []int) { return fileDescriptor11, []int{2} }

func (m *Transaction) GetTimestamp() *google_protobuf.Timestamp {
	if m != nil {
		return m.Timestamp
	}
	return nil
}

func (m *Transaction) GetActions() []*TransactionAction {
	if m != nil {
		return m.Actions
	}
	return nil
}

// TransactionAction binds a proposal to its action.  The type field in the
// header dictates the type of action to be applied to the ledger.
type TransactionAction struct {
	// The header of the proposal action, which is the proposal header
	Header []byte `protobuf:"bytes,1,opt,name=header,proto3" json:"header,omitempty"`
	// The payload of the action as defined by the type in the header For
	// chaincode, it's the bytes of ChaincodeActionPayload
	Payload []byte `protobuf:"bytes,2,opt,name=payload,proto3" json:"payload,omitempty"`
}

func (m *TransactionAction) Reset()                    { *m = TransactionAction{} }
func (m *TransactionAction) String() string            { return proto.CompactTextString(m) }
func (*TransactionAction) ProtoMessage()               {}
func (*TransactionAction) Descriptor() ([]byte, []int) { return fileDescriptor11, []int{3} }

func init() {
	proto.RegisterType((*SignedTransaction)(nil), "protos.SignedTransaction")
	proto.RegisterType((*InvalidTransaction)(nil), "protos.InvalidTransaction")
	proto.RegisterType((*Transaction)(nil), "protos.Transaction")
	proto.RegisterType((*TransactionAction)(nil), "protos.TransactionAction")
	proto.RegisterEnum("protos.InvalidTransaction_Cause", InvalidTransaction_Cause_name, InvalidTransaction_Cause_value)
}

func init() { proto.RegisterFile("peer/fabric_transaction.proto", fileDescriptor11) }

var fileDescriptor11 = []byte{
	// 371 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x09, 0x6e, 0x88, 0x02, 0xff, 0x6c, 0x92, 0x51, 0x6b, 0xea, 0x30,
	0x1c, 0xc5, 0x6f, 0xaf, 0xa8, 0xf8, 0xef, 0xe5, 0xa2, 0x19, 0x93, 0x4e, 0x36, 0x26, 0x7d, 0x72,
	0x1b, 0xb4, 0x50, 0xd9, 0x18, 0x7b, 0x53, 0xe7, 0x83, 0xaf, 0x9d, 0x30, 0x18, 0x8c, 0x91, 0xb6,
	0xb1, 0x06, 0xda, 0xa6, 0x24, 0xa9, 0xd8, 0x2f, 0xb2, 0xaf, 0xb3, 0xaf, 0x36, 0x6c, 0x8c, 0x76,
	0xb8, 0xa7, 0x72, 0xd2, 0x5f, 0xce, 0xff, 0x70, 0xf2, 0x87, 0xab, 0x9c, 0x10, 0xee, 0xae, 0x70,
	0xc0, 0x69, 0xf8, 0x21, 0x39, 0xce, 0x04, 0x0e, 0x25, 0x65, 0x99, 0x93, 0x73, 0x26, 0x19, 0x6a,
	0x55, 0x1f, 0x31, 0xb8, 0x8e, 0x19, 0x8b, 0x13, 0xe2, 0x56, 0x32, 0x28, 0x56, 0xae, 0xa4, 0x29,
	0x11, 0x12, 0xa7, 0xb9, 0x02, 0xed, 0x77, 0xe8, 0xbd, 0xd0, 0x38, 0x23, 0xd1, 0xf2, 0xe8, 0x81,
	0x6e, 0xa1, 0x5b, 0xb3, 0x9c, 0x96, 0x92, 0x08, 0xcb, 0x18, 0x1a, 0xa3, 0x7f, 0xfe, 0xc9, 0x39,
	0xba, 0x84, 0x8e, 0xa0, 0x71, 0x86, 0x65, 0xc1, 0x89, 0xf5, 0xb7, 0x82, 0x8e, 0x07, 0xf6, 0x97,
	0x01, 0x68, 0x91, 0x6d, 0x70, 0x42, 0x7f, 0x0c, 0xb8, 0x07, 0xb3, 0x66, 0x54, 0x79, 0x9b, 0xde,
	0x99, 0x8a, 0x24, 0x9c, 0x1a, 0xe9, 0xd7, 0x39, 0xf4, 0x00, 0xcd, 0x10, 0x17, 0x42, 0xcd, 0xf9,
	0xef, 0x0d, 0xf5, 0x85, 0xd3, 0x09, 0xce, 0x6c, 0xc7, 0xf9, 0x0a, 0xb7, 0x9f, 0xa0, 0x59, 0x69,
	0x74, 0x0e, 0xbd, 0xe5, 0x76, 0x11, 0x4d, 0x12, 0x4e, 0x70, 0x54, 0xce, 0xb7, 0x54, 0x48, 0xd1,
	0xfd, 0x83, 0x06, 0xd0, 0xf7, 0x5f, 0x67, 0x2c, 0x5b, 0x25, 0x34, 0x94, 0xcf, 0x05, 0xa7, 0x59,
	0x3c, 0x63, 0x69, 0x4a, 0x65, 0xd7, 0xb0, 0x3f, 0x0d, 0x30, 0xeb, 0xd1, 0x2d, 0x68, 0x6f, 0x08,
	0x17, 0x3a, 0x76, 0xd3, 0xd7, 0x12, 0x3d, 0x42, 0xe7, 0xd0, 0x6e, 0x95, 0xd0, 0xf4, 0x06, 0x8e,
	0xea, 0xdf, 0xd1, 0xfd, 0x3b, 0x4b, 0x4d, 0xf8, 0x47, 0x18, 0x8d, 0xa1, 0xad, 0xdc, 0x85, 0xd5,
	0x18, 0x36, 0x46, 0xa6, 0x77, 0xf1, 0x4b, 0x15, 0x13, 0x55, 0x88, 0x26, 0xed, 0x39, 0xf4, 0x4e,
	0xfe, 0xa2, 0x3e, 0xb4, 0xd6, 0x04, 0x47, 0x84, 0xef, 0xdf, 0x6b, 0xaf, 0x76, 0xa9, 0x73, 0x5c,
	0x26, 0x0c, 0x47, 0xfb, 0x37, 0xd2, 0x72, 0x7a, 0xf7, 0x76, 0x13, 0x53, 0xb9, 0x2e, 0x02, 0x27,
	0x64, 0xa9, 0xbb, 0x2e, 0x73, 0xc2, 0x13, 0x12, 0xc5, 0x87, 0xe5, 0x52, 0xab, 0x23, 0xdc, 0xdd,
	0xbe, 0x05, 0x6a, 0xad, 0xc6, 0xdf, 0x01, 0x00, 0x00, 0xff, 0xff, 0xc4, 0x48, 0x72, 0x86, 0x7e,
	0x02, 0x00, 0x00,
}
